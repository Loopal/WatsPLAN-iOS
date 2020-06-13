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
                Text("Button")
            }
                .background(Color.black)
            
            Text("Welcome back, Warrior!")
                .font(.title)
            Text("Let's begin your degree check")
                .foregroundColor(Color.gray)
            Spacer()
            
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
            Text("CREATE NEW")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-60,y:-150)
        }
    }
}

