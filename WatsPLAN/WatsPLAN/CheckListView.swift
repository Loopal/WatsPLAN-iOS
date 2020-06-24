//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingButton
import StatusBarColorKit

let SELECT_ALL = 0
let SELECT_CHECK = 1
let SELECT_UNCHECK = 2

struct CheckListView: View {
    
    @Binding var shouldPopToRootView: Bool

    @EnvironmentObject var model : Model
    @State var selected = SELECT_ALL
    @State var showDialog = false
    @State var dialogType = 0
    
    var sourceType: Int
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(30)
        } else {
            return CGFloat(15)
        }
    }
    
    var filteredCards: [Card] {
        switch self.selected {
        case SELECT_ALL:
            return model.cards
        case SELECT_CHECK:
            return model.cards.filter {
                $0.progress == 100
            }
        default:
            return model.cards.filter {
                $0.progress != 100
            }
        }
    }
    
    var buttonOffsetX: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(UIScreen.main.bounds.width/2 - 80)
        } else {
            return CGFloat(UIScreen.main.bounds.width/2 - 30)
        }
    }
    
    /*init(sourceType: Int) {
        self.sourceType = sourceType
    }*/
        
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
            
                VStack(alignment: .center,spacing : 0) {
                    VStack(alignment: .center,spacing : 0){

                    Image("math_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 40.0)
                        .padding(.top, geometry.safeAreaInsets.top)
                        .frame(maxHeight: 125)
                                            
                    Text(self.model.majorName + (self.model.optionName == "" ? "" : " | " + self.model.optionName))
                        .font(.custom("Avenir Next Medium", size:self.fontSize))
                        .foregroundColor(Color.white)
                        .offset(y:-5)
                        .frame(width: UIScreen.main.bounds.width-40)
                    
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
                }
                .background(Color.black)

                List(self.filteredCards) { curcard in
                    ListItemView(id: self.model.cards.firstIndex(where: {(c) -> Bool in
                        return c.id == curcard.id})!)
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = .clear
                }
                 
            }
            .saturation(self.showDialog ? 0.5 : 1)
            .blur(radius: (self.showDialog ? 5 : 0))
            .disabled(self.showDialog)
            .background(Color.white)
            .onAppear {
                self.model.getCollection(type: self.sourceType)
            }
            menu1
                .offset(x: self.buttonOffsetX, y: geometry.size.height/2 - 100)
                .saturation(self.showDialog ? 0.5 : 1)
                .blur(radius: (self.showDialog ? 5 : 0))

            if self.showDialog {
                DialogView(showDialog: self.$showDialog, dialogType: self.$dialogType, shouldPopToRootView: self.$shouldPopToRootView)
            }
            
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            StatusBarColorManager.statusBarStyle = .lightContent
        }
        .onDisappear {
            self.model.resetName()
            StatusBarColorManager.statusBarStyle = .default
        }
    }
}

/*struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(sourceType: 1)
        .environmentObject(Model())
    }
}*/

struct IconButton: View {

    var imageName: String
    var color: Color

    var buttonWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(90)
        } else {
            return CGFloat(70)
        }
    }
    
    var imageWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(40)
        } else {
            return CGFloat(30)
        }
    }
    
    @Binding var showDialog: Bool
    @Binding var dialogType: Int
    var type: Int = 0

    var body: some View {
        ZStack {
            self.color
            
            Circle()
                .fill(Color("uwyellow"))
                .frame(width: buttonWidth - 5, height: buttonWidth - 5)

            Image(systemName: imageName)
                .resizable()
                .frame(width: self.imageWidth, height: self.imageWidth)
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

    
    var buttonWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(90)
        } else {
            return CGFloat(70)
        }
    }
    
    var imageWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(40)
        } else {
            return CGFloat(30)
        }
    }
    

    var body: some View {
        ZStack {
            self.color
            
            Circle()
                .fill(Color("uwyellow"))
                .frame(width: buttonWidth - 5, height: buttonWidth - 5)

            Image(systemName: imageName)
                .resizable()
                .frame(width: self.imageWidth, height: self.imageWidth)
                .foregroundColor(.black)

        }
        .frame(width: self.buttonWidth, height: self.buttonWidth)
        .cornerRadius(self.buttonWidth / 2)
    }

}

