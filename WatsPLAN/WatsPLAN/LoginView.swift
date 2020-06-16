//
//  LoginView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import ValidatedPropertyKit

struct LoginView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 200.0, height: 200.0)
            
            Spacer()
                .frame(height: 20)
            
            LoginCard()
            
            Spacer()
                .frame(height: 50)
            
            NavigationLink(destination: RegisterView()) {
                Text("New Here? Create an Account")
            }
            
            Spacer()
            
        }
    }
}

struct LoginCard: View {
    
    @ObservedObject var viewModel = LoginUserViewModel()
    
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("uwyellow"))
                .frame(width: 350, height: 250)
            //.offset(y: -40)
            
            VStack {
                /*FloatingLabelTextField($loginModel.email.bound, placeholder: "Email", editingChanged: { (isChanged) in}){
                }*/
                
                /*FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in}){
                }*/
                
                FloatingLabelTextField($viewModel.email, placeholder: "Email", editingChanged: { (isChanged) in}){
                }
                /*.leftView( {
                    Button(action: {
                        withAnimation {
                            self.isemailFormat.toggle()
                        }
                    }) {
                        Image(self.isemailFormat ? "envelope" : "warning")
                            .foregroundColor(.black)
                    }
                })*/
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                    .autocapitalization(UITextAutocapitalizationType.none)
                
                /*FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in}){
                    
                }*/
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
                
                
                Button(action: {
                    self.endEditing(true)
                }) {
                    Text("SIGN IN")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .disabled(!viewModel.isValid)
                .offset(y: 55)
                
                
                Text("LOGIN")
                    .font(.custom("Avenir Next Demi Bold", size:30))
                    .offset(x:-110,y:-225)
            }
                
            .shadow(radius: 5)
            
            VStack(alignment: .leading){
                Spacer()
                    .frame(height: 80)
                
                Text(viewModel.emailError ?? "")
                    .frame(height: 20)
                    .foregroundColor(.red)
                    .font(.caption)
                
                Spacer()
                    .frame(width:300, height: 65)
                
                Text(viewModel.passwordError ?? "")
                    .frame(height: 20)
                .foregroundColor(.red)
                .font(.caption)
            }
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

/*extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}*/
