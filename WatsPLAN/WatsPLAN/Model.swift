//
//  Model.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import FirebaseFirestore

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

    
    private var db = Firestore.firestore()
    
    func getCollection() {
        if self.fileName == "" {
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
            //fetch from local dir
            self.storedCards.removeAll()
            self.cards.removeAll()

        }
    }
    
    func saveModel(name: String) {
        let fName = name + ".save"
        let fileManager = FileManager.default
        let path = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:     FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(fName)

        if !fileManager.fileExists(atPath: (path?.absoluteString)!) {
            fileManager.createFile(atPath: String(fName),  contents:Data(" ".utf8), attributes: nil)
        }
        
        let fileHandle = FileHandle(forWritingAtPath: fName)

        if(fileHandle == nil)
        {
            print("Open of outFilename forWritingAtPath: failed.  \nCheck whether the file already exists.  \nIt should already exist.\n");
            return
        }
        fileHandle?.write((self.facultyName + "\n").data(using: .utf8)!)
        fileHandle?.write((self.majorName + " | " + self.optionName + "\n").data(using: .utf8)!)
        for c in self.cards {
            var temp = ""
            temp += c.text + "?"
            temp += c.done.description + "?"
            temp += c.checkedBoxes.map(String.init).joined(separator: ";") + "?"
            temp += String(c.num) + "?"
            temp += String(c.progress) + "?"
            temp += c.items.joined(separator: ";") + "?"
            temp += c.comment + "\n"
            fileHandle?.write(temp.data(using: .utf8)!)
        }
        
        fileHandle!.closeFile()
        self.changed = false
        self.fileName = name
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
