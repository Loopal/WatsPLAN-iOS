//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct CheckListView: View {
    @EnvironmentObject var model : Model
    @State var selected = 0
    
    init() {
        model.facultyName = "asd"
        model.majorName = "asd"
        model.majorName = "Applied Mathematics"
        model.getCollection()
    }
    
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
            
            
            List(model.cards) { card in
                ListItemView(card: card)
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = .clear
            }

        }
        .background(Color.black)
        .onAppear {
        }
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView()
    }
}


