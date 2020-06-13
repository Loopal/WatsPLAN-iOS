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
            
            RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow)
                    .frame(width: 350, height: 150.0)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Load")
                    .foregroundColor(Color.yellow)
                    .frame(width: 200.0, height: 30.0)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.leading, 75)
            .offset(y:-20)


                
        }
        

        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
