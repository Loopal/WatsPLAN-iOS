//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingButton

let SELECT_ALL = 0
let SELECT_CHECK = 1
let SELECT_UNCHECK = 2

struct CheckListView: View {

    @EnvironmentObject var model : Model
    @State var selected = SELECT_ALL
    @State var showDialog = false
    @State var dialogType = 0
    
    var sourceType: Int
    
    init(sourceType: Int) {
        self.sourceType = sourceType
    }
        
    var body: some View {
        
        let menuButton = AnyView(MainButton(imageName: "line.horizontal.3",  color: Color.white))
        
        let saveButton = AnyView(IconButton(imageName: "square.and.arrow.down.fill", color: Color.white, showDialog: self.$showDialog, dialogType: self.$dialogType, type: 0))
        
        let deleteButton = AnyView(IconButton(imageName: "trash.fill", color: Color.white, showDialog: self.$showDialog, dialogType: self.$dialogType, type: 1))


        let menu1 = FloatingButton(mainButtonView: menuButton, buttons: [saveButton, deleteButton])
            .straight()
            .direction(.top)
            .alignment(.left)
            .spacing(10)
            .initialOffset(x: 0)
            .animation(.spring())
        
        return
        GeometryReader { geometry in
            ZStack {
            
            VStack(alignment: .center, spacing : 0) {
                Image("math_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 40.0)
                    .padding(.top, 20)
                    
                Text(self.model.majorName + (self.model.optionName == "" ? "" : " | " + self.model.optionName))
                    .font(.custom("Avenir Next Medium", size:15))
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .offset(y:-5)
                
                Picker(selection: self.$selected, label: Text("adasdas"), content: {
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
                
                List([Int](0..<self.model.cards.count)) { curId in
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
            .disabled(self.showDialog)
            .background(Color.black)
            .onAppear {
                self.model.getCollection(type: self.sourceType)
            }
            menu1
                .offset(x: geometry.size.width/2 - 50, y: geometry.size.height/2 - 40)
            if self.showDialog {
                DialogView(showDialog: self.$showDialog, dialogType: self.$dialogType)
            }
            
            }
        }
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(sourceType: 1)
        .environmentObject(Model())
    }
}

struct IconButton: View {

    var imageName: String
    var color: Color

    let imageWidth: CGFloat = 40
    let buttonWidth: CGFloat = 60
    @Binding var showDialog: Bool
    @Binding var dialogType: Int
    var type: Int = 0

    var body: some View {
        ZStack {
            self.color
            
            Circle()
                .fill(Color("uwyellow"))
                .frame(width: 58, height: 55)

            Image(systemName: imageName)
                .frame(width: self.imageWidth, height: self.imageWidth)
                .imageScale(.large)
                .foregroundColor(.black)
        }
        .onTapGesture {
            self.dialogType = self.type
            self.showDialog = true
        }
        .frame(width: self.buttonWidth, height: self.buttonWidth)
        .cornerRadius(self.buttonWidth / 2)
    }

}

struct MainButton: View {

    var imageName: String
    var color: Color

    let imageWidth: CGFloat = 40
    let buttonWidth: CGFloat = 60

    var body: some View {
        ZStack {
            self.color
            
            Circle()
                .fill(Color("uwyellow"))
                .frame(width: 58, height: 55)

            Image(systemName: imageName)
                .frame(width: self.imageWidth, height: self.imageWidth)
                .imageScale(.large)
                .foregroundColor(.black)
        }
        .frame(width: self.buttonWidth, height: self.buttonWidth)
        .cornerRadius(self.buttonWidth / 2)
    }

}

