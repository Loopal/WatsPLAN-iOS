//
//  PickerView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-17.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    @State var selection: String = ""
    @Binding var isPickerActive: Bool
    @Binding var type : Int
    //@EnvironmentObject var model: Model
    var body: some View {
            return Picker(selection: $selection, label: Text("")) {
                ForEach(0..<5) {_ in
                    Text("asd")
                }
            }
            .font(.custom("Avenir Next Demi Bold", size:30))
            .background(Color("uwyellow"))
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(width: .infinity, height: 300)
            .onAppear{
                //self.model.fetchContent(s: "/Faculties/")
            }
        }/* else if type == 1 {
            return Picker(selection: $model.majorName, label: Text("")) {
                ForEach(0..<self.model.mContent.count) {
                    Text(self.model.mContent[$0])
                }
            }
            .font(.custom("Avenir Next Demi Bold", size:30))
            .background(Color("uwyellow"))
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(height: 300)
            .onAppear{
                self.model.fetchContent(s: "/Faculties/")
            }
        } else {
            return Picker(selection: $model.optionName, label: Text("")) {
                ForEach(0..<self.model.oContent.count) {
                    Text(self.model.oContent[$0])
                }
            }
            .font(.custom("Avenir Next Demi Bold", size:30))
            .background(Color("uwyellow"))
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(height: 300)
            .onAppear{
                self.model.fetchContent(s: "/Faculties/")
            }
        }
    }*/
}

/*
struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(type: 0, content: ["123", "123124512512", "ASDASDAS"])
    }
}*/
