//
//  ContentView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

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
                            .offset(x: self.showMenu ? geometry.size.width/1.3 : 0,
                                    y: self.showPicker ? -200 : 0)
                            .disabled(self.showMenu || self.showPicker ? true : false)
                        if self.showMenu {
                            MenuView(isMenuActive: self.$showMenu)
                                .frame(width: geometry.size.width/1.3)
                                .padding(.leading, -(geometry.size.width - geometry.size.width/1.3))
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
                                        .font(.custom("Avenir Next Demi Bold", size:15))
                                        .foregroundColor(Color("uwyellow"))
                                        .frame(width: UIScreen.main.bounds.width, height: 40)
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
                                    .frame(width: 700, height: 200)
                                    .pickerStyle(WheelPickerStyle())
                                    .onAppear{
                                        self.oldF = self.model.facultyName
                                        self.oldM = self.model.majorName
                                        self.oldO = self.model.optionName
                                    }

                            }
                                .background(Color("uwyellow"))
                                .labelsHidden()
                                .pickerStyle(WheelPickerStyle())
                                .padding(.top, UIScreen.main.bounds.size.height-200)
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
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(Color.black)
                    .imageScale(.large)
            }
            .padding(.top, 10)
            
            Spacer()

            Text("Welcome back, Warrior!")
                .font(.custom("Avenir Next Demi Bold", size:30))
            Text("Let's begin your degree check")
                .font(.custom("Avenir Next Demi Bold", size:20))
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
        ContentView()
        .environmentObject(Model())
    }
}


struct LoadCard: View {
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: UIScreen.main.bounds.width - 20, height: 120)
                
                NavigationLink(destination: CheckListView(sourceType: 1)) {
                      Text("LOAD")
                          .foregroundColor(Color("uwyellow"))
                          .font(.custom("Avenir Next Demi Bold", size:20))
                          .frame(width: UIScreen.main.bounds.width - 150, height:40.0)
                          .background(Color.black)
                          .cornerRadius(10)
                   }
                    .buttonStyle(PlainButtonStyle())
                   //.navigationBarTitle("")
                   //.navigationBarHidden(true)
                    .disabled(model.fileName == "")
                    .offset(y:-30)

            }
            .shadow(radius: 5)
            
            Button(action: {
                self.pickerType = 3
                withAnimation{
                    self.showPicker.toggle()
                }
            }) {
                Text(model.fileName == "" ? "Select your save file" : "Selected: " +  model.fileName)
                    .font(.custom("Avenir Next Demi Bold", size:15))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                    .border(Color.black, width: 3)
            }
            .offset(y:-25)

            
            Text("CONTINUE")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-(UIScreen.main.bounds.width/2 - 110),y:-85)
        }

    }
}

struct CreateCard: View {
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                
                NavigationLink(destination: CheckListView(sourceType : 0)) {
                   Text("CREATE")
                       .foregroundColor(Color("uwyellow"))
                       .font(.custom("Avenir Next Demi Bold", size:20))
                       .frame(width: UIScreen.main.bounds.width - 150, height:40.0)
                       .background(Color.black)
                       .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                //.navigationBarTitle("")
                //.navigationBarHidden(true)
                .disabled(model.facultyName == "" || model.majorName == "")
                .offset(y:-30)
            }
            .shadow(radius: 5)
            
            VStack(spacing: 25) {
                Button(action: {
                    self.pickerType = 0
                    withAnimation{
                        self.showPicker.toggle()
                    }
                    
                }) {
                    Text(model.facultyName == "" ? "Select your faculty" : "Selected: " + model.facultyName)
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
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
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
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
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                        .border(Color.black, width: 3)
                }

            }
            .offset(y:-35)

            
            Text("CREATE NEW")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-(UIScreen.main.bounds.width / 2 - 130), y:-150)
        }
    }
}
