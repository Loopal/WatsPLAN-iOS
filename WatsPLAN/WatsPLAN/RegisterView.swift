//
//  RegisterView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct RegisterView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 200.0, height: 200.0)
            
            Spacer()
                .frame(height: 20)
            
            RegisterCard()
            
            Spacer()
                .frame(height: 50)
            
            NavigationLink(destination: LoginView()) {
                Text("Already Registered? Login Here")
            }
            
            Spacer()
            
        }
    }
}

struct RegisterCard: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isPasswordShow: Bool = false
    @State private var isConfirmedPasswordShow: Bool = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("uwyellow"))
                .frame(width: 350, height: 400)
            //.offset(y: -40)
            
            VStack {
                
                FloatingLabelTextField($name, placeholder: "Full Name", editingChanged: { (isChanged) in}){
                    
                }
                .floatingStyle(ThemeTextFieldStyle())
                .modifier(ThemeTextField())
                
                FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in}){
                    
                }
                .floatingStyle(ThemeTextFieldStyle())
                .modifier(ThemeTextField())
                
                
                FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in}){
                    
                }
                .rightView({
                    Button(action: {
                        withAnimation {
                            self.isPasswordShow.toggle()
                        }
                        
                    }) {
                        Image(self.isPasswordShow ? "eye_close" : "eye_show")
                            .foregroundColor(Color.black)
                    }
                })
                    .isSecureTextEntry(!self.isPasswordShow)
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                
                FloatingLabelTextField($confirmPassword, placeholder: "Confirm Password", editingChanged: { (isChanged) in}){
                    
                }
                .rightView({
                    Button(action: {
                        withAnimation {
                            self.isConfirmedPasswordShow.toggle()
                        }
                        
                    }) {
                        Image(self.isConfirmedPasswordShow ? "eye_close" : "eye_show")
                            .foregroundColor(Color.black)
                    }
                })
                    .isSecureTextEntry(!self.isConfirmedPasswordShow)
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                
            }
            .offset(y: -20)
            
            
            Button(action: {
                self.endEditing(true)
            }) {
                Text("SIGN UP")
                    .foregroundColor(Color("uwyellow"))
                    .frame(width: 200.0, height: 30.0)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .offset(y: 200)
            
            
            Text("Register")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-110,y:-200)
        }
            
        .shadow(radius: 5)
        
        /*VStack(alignment: .leading) {
         
         //.offset(y: -320)
         }*/
        
        
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
