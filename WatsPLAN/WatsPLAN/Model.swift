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
    @Published var storedCards: [Card] = []
    @Published var cards: [Card] = []
    @Published var filterlen = 0
    
    @Published var fContent: [String] = []
    @Published var mContent: [String] = []
    @Published var oContent: [String] = []

    
    private var db = Firestore.firestore()
    
    func getCollection() {
        if self.fileName == "" {
            //load from db
            var docRef = db.collection("/Majors/").document(optionName == "" ? self.majorName : self.majorName + " | " + self.optionName)
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
                        self.filterlen = self.cards.count
                    } else {
                        print("Document does not exist")
                    }
                }
        } else {
            //load from storage
        }

    }
    
    func fetchContent(s: String) {
        
        db.collection(s).addSnapshotListener { (querySnapshot, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                } else {
                    self.fContent = querySnapshot!.documents.map{queryDocumentSnapshot -> String in
                        return queryDocumentSnapshot.documentID }
                    print(self.fContent)
                }
            }
        }
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
}
