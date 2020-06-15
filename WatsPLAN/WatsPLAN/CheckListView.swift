//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct CheckListView: View {
    
    @State var selected = 0
    @EnvironmentObject var model : Model

    var cards : [Card]
    var storedCards : [Card]
    var body: some View {
        return VStack(spacing : 0) {
            Image("math_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 40.0)
                .padding(.top, 20)
                
            Text(model.majorName)
                .font(.custom("Avenir Next Medium", size:15))
                .background(Color.black)
                .foregroundColor(Color.white)
                .offset(y:-5)
            
            Picker(selection: $selected, label: Text("adasdas"), content: {
                Text("ALL").tag(0)
                Text("UNCHECKED").tag(1)
                Text("CHECKED").tag(2)
            })
            .cornerRadius(0)
                .pickerStyle(SegmentedPickerStyle())
                .onAppear{
                    UISegmentedControl.appearance()
                        .selectedSegmentTintColor = UIColor(named: "uwyellow")
                    UISegmentedControl.appearance()
                        .setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15),.foregroundColor: UIColor.black], for: .selected)
                    UISegmentedControl.appearance()
                        .setTitleTextAttributes([.foregroundColor: UIColor(named: "uwyellow")!], for: .normal)

                }
            
            
            List(cards) { card in
                ListItemView(card: card)
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = .clear
            }

        }
        .background(Color.black)


        
    }
}

/*
struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(cards : [Card(id : 0, text: "Some Text",items : ["CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])], storedCards: [Card(id : 0, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])])
    }
}
 */

private func getCollection(model:Model) {
    if model.fileName != "" {
        //load from db
        let db = Firestore.firestore()
        var docRef = db.collection("/Majors/").document(model.majorName)
        docRef.getDocument { (document, error) in
                if let major = document.flatMap({
                  $0.data().flatMap({ (data) in
                    return Major(dictionary: data)
                  })
                }) {
                    var count = 0
                    for item in major.Requirements {
                        var temp = item.components(separatedBy: ";")
                        model.cards.append(Card(id : count, text: temp[0], num: Int(temp[1]) ?? 0, items: [String](temp[2...temp.count])))
                        count += 1
                    }
                } else {
                    print("Document does not exist")
                }
            }
    } else {
        //load from storage
    }

}



fileprivate struct Major {
    let Requirements : [String]
    init?(dictionary: [String: Any]) {
        Requirements = dictionary["Requirements"] as! [String]
    }
}
