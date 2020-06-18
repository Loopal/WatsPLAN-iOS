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
    
    var body: some View {
        
        let dragMenu = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = true
                    }
                } else if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
                if $0.translation.height > 50 {
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
                                y: self.showPicker ? -300 : 0)
                        .disabled(self.showMenu || self.showPicker ? true : false)
                    if self.showMenu {
                        MenuView(isMenuActive: self.$showMenu)
                            .frame(width: geometry.size.width/1.3)
                            .padding(.leading, -(geometry.size.width - geometry.size.width/1.3))
                            .transition(.move(edge: .leading))
                    }
                    if self.showPicker {
                        /*PickerView(isPickerActive: self.$showPicker, type: self.$pickerType)
                            .frame(height: geometry.size.height/3)
                            .transition(.move(edge: .bottom))*/
                        VStack(alignment: .center){
                            Button(action: {
                                withAnimation{
                                    self.showPicker = false
                                }
                                
                            }) {
                                Text("CONFIRM")
                                    .font(.custom("Avenir Next Demi Bold", size:15))
                                    .foregroundColor(Color("uwyellow"))
                                    .frame(width: 700, height: 40)
                                    .background(Color.black)
                            }
                            
                            Picker(selection: self.$model.majorName, label: Text("")) {
                                ForEach(0..<self.model.fContent.count) { index in
                                    Text("\(self.model.fContent[index])").tag(index)
                                    .font(.custom("Avenir Next Demi Bold", size:20))
                                }
                                
                            }
                            .frame(width: 700)
                            .pickerStyle(WheelPickerStyle())

                            
                            }
                            .background(Color("uwyellow"))
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            .padding(.top, geometry.size.height-200)
                        .onAppear{
                                self.model.fetchContent(s: "/Faculties/")
                            }
                            .transition(.move(edge: .bottom))
                        }

                    
                    
                }
                .gesture(dragMenu)
            }
            .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(Color.black)
                            .imageScale(.large)
                    }
                ))
        }
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @Binding var showPicker: Bool
    @Binding var pickerType: Int
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            
            Text("Welcome back, Warrior!")
                .font(.custom("Avenir Next Demi Bold", size:30))
            Text("Let's begin your degree check")
                .font(.custom("Avenir Next Demi Bold", size:20))
                .foregroundColor(Color.gray)
            Spacer()
                .frame(height: 50)
            
            LoadCard()
            
            CreateCard(showPicker: self.$showPicker, pickerType: self.$pickerType)


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
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: 350, height: 100)
                
                   NavigationLink(destination: CheckListView()) {
                      Text("LOAD")
                          .foregroundColor(Color("uwyellow"))
                          .font(.custom("Avenir Next Demi Bold", size:15))
                          .frame(width: 200.0, height:40.0)
                          .background(Color.black)
                          .cornerRadius(10)
                   }
                   .buttonStyle(PlainButtonStyle())
                   //.navigationBarTitle("")
                   //.navigationBarHidden(true)
                   .offset(y:-30)

            }
            .shadow(radius: 5)
            
            Text("CONTINUE")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-75,y:-75)
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
                    .frame(width: 350, height: 250)
                
                Button(action: {}) {
                    Text("CREATE")
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 40)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .offset(y:-30)
            }
            .shadow(radius: 5)
            
            VStack {
                Button(action: {
                    self.pickerType = 0
                    withAnimation{
                        self.showPicker.toggle()
                    }
                    
                }) {
                    Text(model.facultyName == "" ? "Select your faculty" : model.facultyName)
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: 330, height: 40)
                        .border(Color.black, width: 5)
                }
                Button(action: {
                }) {
                    Text(model.facultyName == "" ? "Select your program" : model.majorName)
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: 330, height: 40)
                        .border(Color.black, width: 5)
                }
                Button(action: {
                }) {
                    Text(model.facultyName == "" ? "Select your option (if applicable)" : model.optionName)
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .foregroundColor(Color.black)
                        .frame(width: 330, height: 40)
                        .border(Color.black, width: 5)
                }

            }
            .offset(y:-50)

            
            Text("CREATE NEW")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-60,y:-150)
        }
    }
}
