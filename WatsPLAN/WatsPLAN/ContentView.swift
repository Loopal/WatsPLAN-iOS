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
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Button")
            }
                .background(Color.black)
            
            Text("Welcome back, Warrior!")
                .font(.title)
            Text("Let's begin your degree check")
                .foregroundColor(Color.gray)
            
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
                    Text("Load")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .offset(y:-20)
                
            }
            .shadow(radius: 5)
            
            Text("CONTINUE")
                .font(.title)
                .offset(x:-85,y:-70)
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
                    Text("Create")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .offset(y:-20)
            }
            .shadow(radius: 5)
            Text("CREATE NEW")
                .font(.title)
                .offset(x:-75,y:-145)
        }
    }
}

