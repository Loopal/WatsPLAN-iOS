//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

let SELECT_ALL = 0
let SELECT_CHECK = 1
let SELECT_UNCHECK = 2

struct CheckListView: View {

    @EnvironmentObject var model : Model
    @State var selected = SELECT_ALL
        
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
                Text("ALL").tag(SELECT_ALL)
                Text("CHECKED").tag(SELECT_CHECK)
                Text("UNCHECKED").tag(SELECT_UNCHECK)
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
            
            List([Int](0..<model.cards.count)) { curId in
                if self.selected == SELECT_ALL ||
                    (self.selected == SELECT_CHECK && self.model.cards[curId].progress == 100) ||
                (self.selected == SELECT_UNCHECK && self.model.cards[curId].progress != 100)
                {
                    ListItemView(id: curId)
                }
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = .clear
            }
            

        }
        .background(Color.black)
        .onAppear {
            self.model.majorName = "Applied Mathematics"
            self.model.getCollection()
        }
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView()
    }
}

