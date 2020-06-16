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
    
    @ObservedObject private var viewModel = RegisterUserViewModel()
    
    @State private var isPasswordShow: Bool = false
    @State private var isConfirmedPasswordShow: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("uwyellow"))
                .frame(width: 350, height: 400)
            //.offset(y: -40)
            
            VStack {
                
                FloatingLabelTextField($viewModel.username, placeholder: "User Name", editingChanged: { (isChanged) in}){
                    
                }
                .floatingStyle(ThemeTextFieldStyle())
                .modifier(ThemeTextField())
                .autocapitalization(UITextAutocapitalizationType.none)
                
                FloatingLabelTextField($viewModel.email, placeholder: "Email", editingChanged: { (isChanged) in}){
                    
                }
                .floatingStyle(ThemeTextFieldStyle())
                .modifier(ThemeTextField())
                .autocapitalization(UITextAutocapitalizationType.none)
                
                
                FloatingLabelTextField($viewModel.password, placeholder: "Password", editingChanged: { (isChanged) in}){
                    
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
                
                FloatingLabelTextField($viewModel.confirmPassword, placeholder: "Confirm Password", editingChanged: { (isChanged) in}){
                    
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
            //.offset(y: 10)
            
            
            Button(action: {
                self.endEditing(true)
            }) {
                Text("SIGN UP")
                    .foregroundColor(Color("uwyellow"))
                    .frame(width: 200.0, height: 30.0)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .disabled(!viewModel.isValid)
            .offset(y: 385)
            
            
            Text("Register")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x: -100,y: -20)
            
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 80)
                
                Text(viewModel.userNameError ?? "")
                    .frame(height: 20)
                    .foregroundColor(.red)
                    .font(.caption)
                
                Spacer()
                    .frame(height: 65)
                
                Text(viewModel.emailError ?? "")
                    .frame(height: 20)
                    .foregroundColor(.red)
                    .font(.caption)
                
                Spacer()
                    .frame(height: 70)
                
                Text(viewModel.passwordError ?? "")
                    .frame(width: 300, height: 60)
                    .foregroundColor(.red)
                    .font(.caption)
                
                Spacer()
                    .frame(height: 30)
                
                Text(viewModel.confirmPasswordError ?? "")
                    .frame(height: 20)
                    .foregroundColor(.red)
                    .font(.caption)
                
                
                Spacer()
                    .frame(width:300, height: 10)
                
            }
        }
            
        //.shadow(radius: 5)
        
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
