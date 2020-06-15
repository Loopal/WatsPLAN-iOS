//
//  LoginView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

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
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                RoundedRectangle(cornerRadius: 10)
                .fill(Color("uwyellow"))
                .frame(width: 350, height: 200)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("SIGN IN")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .offset(y: -80)
            }
            .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in}){
                    
                }
                
                
                FloatingLabelTextField($password, placeholder: "Password")
            }
            
            Text("LOGIN")
                .font(.title)
                .offset(x:-110,y:-250)
        }
    }
}

//MARK: Create floating style
struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(Color("uwyellow"))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
