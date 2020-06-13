//
//  LoginView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 200.0, height: 200.0)
            
            LoginCard()
            
        }
    }
}

struct LoginCard: View {
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: 350, height: 200)
                
                
                TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .offset(x: 50, y: -150)
                
                SecureField("Password", text: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/.constant(",Apple")/*@END_MENU_TOKEN@*/)
                    .offset(x: 50, y: -100)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("SIGN IN")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .offset(y: -80)
                
                Spacer()
                    .frame(height: 200)
            }
            .shadow(radius: 5)
            
            Text("LOGIN")
                .font(.title)
                .offset(x:-110,y:-250)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
