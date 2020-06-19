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
        
        var data = ""
        data += self.facultyName + "\n"
        data += self.majorName + " | " + self.optionName + "\n"
        for c in self.cards {
            data += c.text + "?"
            data += c.done.description + "?"
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
            var input2 = try String(contentsOf: url)
            print(input2)

            try data.write(to: url, atomically: true, encoding: .utf8)
            
            input2 = try String(contentsOf: url)
            print(input2)
        } catch {
            print(error.localizedDescription)
        }

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
