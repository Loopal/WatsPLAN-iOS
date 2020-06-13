//
//  ContentView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment:.leading) {
            
            Spacer()

            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .font(.system(size: 40, weight: .bold))
                
            }
            Spacer()
            
            
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
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                AutoCompleteTextField(frame: CGRect(x: 20, y: 64, width: 330, height: 40), dataSource: `YourDataSource`, delegate: `AppDelegate`)

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

