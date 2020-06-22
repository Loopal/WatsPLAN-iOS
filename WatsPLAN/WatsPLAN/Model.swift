//
//  Model.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase
import MaterialComponents.MaterialSnackbar

class Model: ObservableObject {
    @Published var fileName = ""
    @Published var facultyName = ""
    @Published var majorName = ""
    @Published var optionName = ""
    @Published var changed = false
    @Published var done = false
    @Published var storedCards: [Card] = []
    @Published var cards: [Card] = []
    
    @Published var fContent: [String] = []
    @Published var mContent: [String] = []
    @Published var oContent: [String] = []
    @Published var fileContent: [String] = []
    
    
    let storage = Storage.storage()
    
    private var db = Firestore.firestore()
    
    func getCollection(type: Int) {
        
        // Clear the cards
        resetCard()
        
        if type == 0 {
            //load from db
            if self.optionName == "!Just click CREATE button if no option" {
                self.optionName = ""
            }
            var docRef = db.collection("/Majors/").document(self.optionName == "" ? self.majorName : self.majorName + " | " + self.optionName)
            docRef.getDocument { (document, error) in
                    if let major = document.flatMap({
                      $0.data().flatMap({ (data) in
                        return Major(dictionary: data)
                      })
                    }) {
                        var count = 0
                        for item in major.Requirements {
                            let temp = item.components(separatedBy: ";")
                            self.storedCards.append(Card(id : count, text: temp[0], num: Int(temp[1]) ?? 0, items: [String](temp[2...temp.count-1])))
                            count += 1
                        }
                        self.cards.append(contentsOf: self.storedCards)
                    } else {
                        print("Document does not exist")
                    }
                }
        } else {
            //load from storage
            self.storedCards.removeAll()
            self.cards.removeAll()
            
            let fileManager = FileManager.default
            let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(self.fileName + ".save")
            do {
                let data: [String] = try String(contentsOf: url).split(whereSeparator: \.isNewline).map(String.init)
                self.facultyName = data[0]
                
                let m_o = data[1].split(separator: "|").map(String.init)
                self.majorName = String(m_o[0][..<m_o[0].endIndex])
                self.optionName = (String(m_o[1][m_o[1].startIndex...]) == " " ? "" : String(m_o[1][m_o[1].startIndex...]))

                var lineNum = 2
                while lineNum < data.count {
                    let lineData = data[lineNum].split(separator: "?", omittingEmptySubsequences: false).map(String.init)

                    var curCard = Card(id: lineNum - 2, text: lineData[0], done: false, num: Int(lineData[3])!, items:  lineData[5].split(separator: ";").map(String.init))
                    
                    curCard.progress = Int(lineData[4])!
                    curCard.checkedBoxes = []

                    if lineData[2] != "" {
                        curCard.checkedBoxes = []
                        let sl = lineData[2].split(separator: ";").map(String.init)
                        for s in sl {
                            curCard.checkedBoxes.append(Int(s)!)
                        }
                    }
                    curCard.comment = lineData[6]
                    self.storedCards.append(curCard)
                    lineNum += 1
                }
                self.cards.append(contentsOf: self.storedCards)

            } catch {
                print(error.localizedDescription)
            }
        }

    }
    
    func fetchContent(s: String, type: Int) {
        if (type == 0) {
            self.majorName = ""
            self.optionName = ""
        } else if (type == 1) {
            self.optionName = ""
        }
        
        if (type != 3){
            //fetch from sever
            db.collection(s).addSnapshotListener { (querySnapshot, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
                    } else {
                        if type == 0 {
                            self.fContent = querySnapshot!.documents.map{queryDocumentSnapshot -> String in
                                return queryDocumentSnapshot.documentID }
                        } else if type == 1 {
                            self.mContent = querySnapshot!.documents.map{queryDocumentSnapshot -> String in
                                return queryDocumentSnapshot.documentID }
                        } else {
                            self.oContent = querySnapshot!.documents.map{queryDocumentSnapshot -> String in
                                return queryDocumentSnapshot.documentID }
                        }
                    }
                }
            }
        } else {
            //fetch.save files from local dir
            self.fileContent.removeAll()
            
            let fileManager = FileManager.default
            let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
                for save in (directoryContents.filter{ $0.pathExtension == "save" }) {
                    self.fileContent.append(save.lastPathComponent.components(separatedBy: ".")[0])
                }
            } catch {
                print("error load from document")
            }
        }
    }
    
    func saveModel(name: String) {
        
        var data = ""
        data += self.facultyName + "\n"
        data += self.majorName + " | " + self.optionName + "\n"
        for c in self.cards {
            data += c.text + "?"
            data += "false" + "?"
            data += c.checkedBoxes.map(String.init).joined(separator: ";") + "?"
            data += String(c.num) + "?"
            data += String(c.progress) + "?"
            data += c.items.joined(separator: ";") + "?"
            data += c.comment + "\n"
        }
        
        let fName = name + ".save"
        
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fName)
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        
        let currentUser = Auth.auth().currentUser
        let currentUID = currentUser?.uid
        
        if(currentUID != nil){
            let storageRef = storage.reference(withPath: "userData/" + currentUID!)
            let fileRef = storageRef.child(fName)
            
            let uploadTask = fileRef.putFile(from: url, metadata: nil) { metadata, error in
                if let error = error {
                    let message = MDCSnackbarMessage()
                    message.text = "Cloud Sync Fail"
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                    print(error)
                }
                else{
                    let message = MDCSnackbarMessage()
                    message.text = "Cloud Sync Succeed"
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                }
                
                /*guard let metadata = metadata else {
                    let message = MDCSnackbarMessage()
                    message.text = "Cloud Sync Fail"
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                    print(error)
                    return
                }*/
            }
        }

        self.changed = false
        self.fileName = name
    }
    
    func deleteFile() {
        let fName = self.fileName + ".save"
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fName)
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
        
        let currentUser = Auth.auth().currentUser
        let currentUID = currentUser?.uid
        
        if(currentUID != nil){
            let storageRef = storage.reference(withPath: "userData/" + currentUID!)
            let fileRef = storageRef.child(fName)
            
            let deleteTask = fileRef.delete { error in
                if let error = error {
                    let message = MDCSnackbarMessage()
                    message.text = "Cloud Sync Fail"
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                    print(error)
                }
                else{
                    let message = MDCSnackbarMessage()
                    message.text = "Cloud Sync Succeed"
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                }
            }
        }
        
        self.fetchContent(s: "", type: 3)
    }
    
    func resetModel() {
        self.cards.removeAll()
        self.storedCards.removeAll()
        self.fileName = ""
        self.facultyName = ""
        self.majorName = ""
        self.optionName = ""
        self.mContent = []
        self.oContent = []
    }
    
    func resetCard() {
        self.cards.removeAll()
        self.storedCards.removeAll()
    }
    
    func resetName() {
        self.fileName = ""
        self.facultyName = ""
        self.majorName = ""
        self.optionName = ""
        self.mContent = []
        self.oContent = []
    }

}


fileprivate struct Major {
    let Requirements : [String]
    init?(dictionary: [String: Any]) {
        Requirements = dictionary["Requirements"] as! [String]
    }
}

extension String: Identifiable {
    public var id: String { self }
    func stringAt(_ i: Int) -> String {
      return String(Array(self)[i])
    }
}
