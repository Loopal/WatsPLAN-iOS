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
            
            Spacer()
            .frame(height: 100)
            
            LoginCard()
            
            Text("New Here? Create an Account")
                .offset(y: -200)
            
            
            
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
                VStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: 350, height: 250)
                        .offset(y: -40)
                    
                    Button(action: {
                        self.endEditing(true)
                    }) {
                        Text("SIGN IN")
                            .foregroundColor(Color("uwyellow"))
                            .frame(width: 200.0, height: 30.0)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .offset(y: -60)
                    
                }
                .shadow(radius: 5)
                
                VStack(alignment: .leading) {
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
                    
                }
                .offset(y: -320)
            }
            
            
            
            Text("LOGIN")
                .font(.custom("Avenir Next Demi Bold", size:30))
                .offset(x:-110,y:-275)
        }
    }
}

//MARK: Create floating style
struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(.black)
            .textColor(.black)
            .selectedTextColor(.black)
            .lineHeight(CGFloat(2))
            .selectedTitleColor(.black)
            .selectedLineColor(.black)
            .selectedLineHeight(CGFloat(2))
    }
}

//MARK: ViewModifier
struct ThemeTextField: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(height: 80)
            .frame(width: 300)
    }
}

//MARK: ViewModifier
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//MARK: Button style
struct CreateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(Color.orange)
            .cornerRadius(10.0)
    }
}
