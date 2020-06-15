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
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/1.3 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/1.3)
                            .transition(.move(edge: .leading))
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
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Text("Welcome back, Warrior!")
                .font(.custom("Avenir Next Demi Bold", size:30))
            Text("Let's begin your degree check")
                .font(.custom("Avenir Next Demi Bold", size:20))
                .foregroundColor(Color.gray)
            Spacer()
                .frame(height: 50)
            
            LoadCard()
            
            CreateCard()


                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct LoadCard: View {
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: 350, height: 100)
                
                Button(action: {CheckListView(cards : [Card(id : 0, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])], storedCards: [Card(id : 0, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])])}) {
                    Text("LOAD")
                        .foregroundColor(Color("uwyellow"))
                        .font(.custom("Avenir Next Demi Bold", size:15))
                        .frame(width: 200.0, height:40.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
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
    @State private var faculty: String = ""
    @State private var program: String = ""
    @State private var option: String = ""
    
    
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


                TextField("Enter or select your faculty", text: $faculty)
                    .frame(width: 330, height : 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Enter or select your program", text: $program)
                    .frame(width: 330, height : 40)
                    .border(Color.black)
                    .cornerRadius(5)
                
                TextField("Enter or select your option(if applicable)", text: $option)
                    .frame(width: 330, height : 40)
                    .border(Color.black)
                    .cornerRadius(5)

            }
            .offset(y:-50)

            
            Text("CREATE NEW")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-60,y:-150)
        }
    }
}

