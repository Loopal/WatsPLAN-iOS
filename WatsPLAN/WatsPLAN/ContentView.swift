//
//  ContentView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import StatusBarColorKit

struct ContentView: View {
    
    @State var showMenu = false
    @State var showPicker = false
    @State var pickerType = 0
    @EnvironmentObject var model: Model
    
    @State var oldF = ""
    @State var oldM = ""
    @State var oldO = ""
    
    func refresh() {
        if self.model.facultyName != self.oldF && self.model.facultyName != "" {
            self.model.fetchContent(s: "/\(self.model.facultyName)/", type : 1)
        }
        if self.model.majorName != self.oldM && self.model.facultyName != ""{
            self.model.fetchContent(s: "/\(self.model.majorName)/", type : 2)
        }
    }
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(50)
        } else {
            return CGFloat(30)
        }
    }
    
    var pickerHeight: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(300)
        } else {
            return CGFloat(200)
        }
    }
    
    var menuwidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(UIScreen.main.bounds.width * 0.3)
        } else {
            return CGFloat(UIScreen.main.bounds.width * 0.7)
        }
    }
    
    var menuPad: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-(UIScreen.main.bounds.width - self.menuwidth)/1.4)
        } else {
            return CGFloat(-(UIScreen.main.bounds.width - self.menuwidth))
        }
    }
    
    var pickerButtonHeight: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(60)
        } else {
            return CGFloat(40)
        }
    }
    
    var pickerOffsetHeight: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(375)
        } else {
            return CGFloat(200)
        }
    }
    
    
    var body: some View {
        
        let dragMenu = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = true
                    }
                } else if $0.translation.width < -100 {
                    /*withAnimation {
                        self.showMenu = false
                    }*/
                    self.showMenu = false
                }
                if $0.translation.height > 50 {
                    self.refresh()
                    withAnimation {
                        self.showPicker = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        MainView(showMenu: self.$showMenu, showPicker: self.$showPicker, pickerType: self.$pickerType)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? self.menuwidth : 0,
                                    y: self.showPicker ? -self.pickerOffsetHeight : 0)
                            .disabled(self.showMenu || self.showPicker ? true : false)
                        if self.showMenu {
                            MenuView(isMenuActive: self.$showMenu)
                                .frame(width: self.menuwidth)
                                .padding(.leading, self.menuPad)
                                .transition(.move(edge: .leading))
                        }
                        
                        if self.showPicker && (self.pickerType == 0 || self.pickerType == 3 || (self.pickerType == 1 && self.model.facultyName != "") ||
                            (self.pickerType == 2 && self.model.facultyName != "" && self.model.majorName != ""))
                            {

                                VStack(alignment: .center, spacing: 0){
                                Button(action: {
                                    self.refresh()
                                    withAnimation{
                                        self.showPicker = false
                                    }
                                    
                                }) {
                                    Text("CONFIRM")
                                        .font(.custom("Avenir Next Demi Bold", size:self.fontSize - 15))
                                        .foregroundColor(Color("uwyellow"))
                                        .frame(width: UIScreen.main.bounds.width, height: self.pickerButtonHeight)
                                        .background(Color.black)
                                }
                                
                                    Picker(selection: self.pickerType == 0 ? self.$model.facultyName :
                                        (self.pickerType == 1 ? self.$model.majorName :
                                            (self.pickerType == 2 ? self.$model.optionName : self.$model.fileName))
                                    , label: Text("")) {
                                        ForEach(self.pickerType == 0 ? self.model.fContent :
                                        (self.pickerType == 1 ? self.model.mContent :
                                            (self.pickerType == 2 ? self.model.oContent : self.model.fileContent))) { f in
                                            Text(f)
                                                .font(.custom("Avenir Next Demi Bold", size:20))
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width, height: self.pickerHeight)
                                    .pickerStyle(WheelPickerStyle())
                                    .onAppear{
                                        self.oldF = self.model.facultyName
                                        self.oldM = self.model.majorName
                                        self.oldO = self.model.optionName
                                    }

                            }
                                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                                .background(Color("uwyellow"))
                                .labelsHidden()
                                    .padding(.top, UIScreen.main.bounds.size.height-self.pickerHeight)
                                .transition(.move(edge: .bottom))
                            }

                        
                        
                    }
                    .gesture(dragMenu)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            /*.navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(Color.black)
                            .imageScale(.large)
                    }
                ))*/
            .onAppear{
                self.model.fetchContent(s: "/Faculties/", type: 0)
                self.model.fetchContent(s: "", type: 3)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(50)
        } else {
            return CGFloat(30)
        }
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .resizable()
                    .foregroundColor(Color.black)
                    .frame(width: 30, height: 20)
                //.imageScale(.large)
            }
            .padding(.top, 10)
            
            Spacer()

            Text("Welcome back, Warrior!")
                .font(.custom("Avenir Next Demi Bold", size: fontSize))
            Text("Let's begin your degree check")
                .font(.custom("Avenir Next Demi Bold", size: fontSize - 10))
                .foregroundColor(Color.gray)
            Spacer()
            Spacer()
            Spacer()
            
            LoadCard(showPicker: self.$showPicker, pickerType: self.$pickerType)
            Spacer()
                .frame(height: 10)
            CreateCard(showPicker: self.$showPicker, pickerType: self.$pickerType)
            
            //Spacer()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11 Pro", "iPad Pro (11-inch) (2nd generation)"], id: \.self) { device in
            ContentView()
            .environmentObject(Model())
            .previewDevice(PreviewDevice(rawValue: device))
        }
    }
}


struct LoadCard: View {
    
    @State var isActive: Bool = false
    
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    @EnvironmentObject var model: Model
    
    var baseWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return UIScreen.main.bounds.width - 40
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(50)
        } else {
            return CGFloat(30)
        }
    }
    
    var rectHeight: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(170)
        } else {
            return CGFloat(120)
        }
    }
    
    var titleOffsetX: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-(UIScreen.main.bounds.width/2 - 180))
        } else {
            return CGFloat(-(UIScreen.main.bounds.width/2 - 110))
        }
    }
    
    var titleOffsetY: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-125)
        } else {
            return CGFloat(-85)
        }
    }
    
    var buttonOffsetY: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-40)
        } else {
            return CGFloat(-25)
        }
    }
    
    var cardPad: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(10)
        } else {
            return CGFloat(0)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: baseWidth - 20, height: rectHeight)
                
                NavigationLink(destination: CheckListView(shouldPopToRootView: self.$isActive, sourceType: 1), isActive: self.$isActive) {
                      Text("LOAD")
                          .foregroundColor(Color("uwyellow"))
                          .font(.custom("Avenir Next Demi Bold", size:fontSize - 10))
                          .frame(width: baseWidth - 150, height: fontSize + 10)
                          .background(Color.black)
                          .cornerRadius(10)
                   }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(model.fileName == "")
                    .offset(y:-fontSize)

            }
            .shadow(radius: 5)
            
            Button(action: {
                self.pickerType = 3
                withAnimation{
                    self.showPicker.toggle()
                }
            }) {
                Text(model.fileName == "" ? "Select your save file" : "Selected: " +  model.fileName)
                    .font(.custom("Avenir Next Demi Bold", size: fontSize - 15))
                    .foregroundColor(Color.black)
                    .frame(width: baseWidth - 40, height: fontSize + 10)
                    .border(Color.black, width: 3)
            }
            .offset(y: buttonOffsetY)

            
            Text("CONTINUE")
                .font(.custom("Avenir Next Demi Bold", size: fontSize))
                .offset(x: titleOffsetX,y:titleOffsetY)
        }
        .padding(.leading, cardPad)

    }
}

struct CreateCard: View {
    
    @State var isActive: Bool = false
    
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    @EnvironmentObject var model: Model
    
    var baseWidth: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return UIScreen.main.bounds.width - 40
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
        var fontSize: CGFloat {
            if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(50)
        } else {
            return CGFloat(30)
        }
    }
    
    var rectHeight: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(400)
        } else {
            return CGFloat(250)
        }
    }
    
    var titleOffsetX: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-(UIScreen.main.bounds.width/2 - 220))
        } else {
            return CGFloat(-(UIScreen.main.bounds.width/2 - 130))
        }
    }
    
    var titleOffsetY: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-240)
        } else {
            return CGFloat(-155)
        }
    }
    var buttonOffsetY: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(-50)
        } else {
            return CGFloat(-35)
        }
    }
    
    var spacing: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(50)
        } else {
            return CGFloat(25)
        }
    }
    
    var cardPad: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(10)
        } else {
            return CGFloat(0)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: baseWidth - 20, height: rectHeight)
                
                
                NavigationLink(destination: CheckListView(shouldPopToRootView: self.$isActive, sourceType: 0), isActive: self.$isActive) {
                   Text("CREATE")
                       .foregroundColor(Color("uwyellow"))
                       .font(.custom("Avenir Next Demi Bold", size:fontSize - 10))
                       .frame(width: baseWidth - 150, height:fontSize + 10)
                       .background(Color.black)
                       .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                //.navigationBarTitle("")
                //.navigationBarHidden(true)
                .disabled(model.facultyName == "" || model.majorName == "")
                .offset(y:-fontSize)
            }
            .shadow(radius: 5)
            
            VStack(spacing: spacing) {
                Button(action: {
                    self.pickerType = 0
                    withAnimation{
                        self.showPicker.toggle()
                    }
                    
                }) {
                    Text(model.facultyName == "" ? "Select your faculty" : "Selected: " + model.facultyName)
                        .font(.custom("Avenir Next Demi Bold", size:fontSize - 15))
                        .foregroundColor(Color.black)
                        .frame(width: baseWidth - 40, height: fontSize + 10)
                        .border(Color.black, width: 3)
                }
                Button(action: {
                    if (self.model.facultyName != ""){
                        self.pickerType = 1
                        withAnimation{
                            self.showPicker.toggle()
                        }
                    }
                }) {
                    Text(model.majorName == "" ? "Select your program" : "Selected: " + model.majorName)
                        .font(.custom("Avenir Next Demi Bold", size:fontSize - 15))
                        .foregroundColor(Color.black)
                        .frame(width: baseWidth - 40, height: fontSize + 10)
                        .border(Color.black, width: 3)
                }
                Button(action: {
                    if (self.model.majorName != ""){
                        self.pickerType = 2
                        withAnimation{
                            self.showPicker.toggle()
                        }
                    }
                }) {
                    Text(model.optionName == "" ? "Select your option (if applicable)" : "Selected: " +  model.optionName)
                        .font(.custom("Avenir Next Demi Bold", size:fontSize - 15))
                        .foregroundColor(Color.black)
                        .frame(width: baseWidth - 40, height: fontSize + 10)
                        .border(Color.black, width: 3)
                }

            }
            .offset(y:buttonOffsetY)

            
            Text("CREATE NEW")
                .font(.custom("Avenir Next Demi Bold", size:fontSize))
                .offset(x:titleOffsetX, y:titleOffsetY)
        }
        .padding(.leading, cardPad)
    }
}


