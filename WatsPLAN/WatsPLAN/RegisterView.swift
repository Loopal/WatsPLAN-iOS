//
//  RegisterView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import FirebaseAuth
import MaterialComponents.MaterialSnackbar
import StatusBarColorKit

struct RegisterView: View {
    
    @Binding var shouldPopToRootView: Bool
    
    @Binding var isMenuActive: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("logo")
                .resizable()
                .frame(width: 150, height: 150)
            
            RegisterCard(shouldPopToRootView: self.$shouldPopToRootView, isMenuActive: self.$isMenuActive)
            
            Spacer()
                .frame(height: 40)
            
            NavigationLink(destination: LoginView(shouldPopToRootView: self.$shouldPopToRootView, isMenuActive: self.$isMenuActive)) {
                Text("Already Registered? Login Here")
            }
            
            Spacer()
                .frame(height: 40)


        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct RegisterCard: View {
    
    @Binding var shouldPopToRootView: Bool
    
    @Binding var isMenuActive: Bool
    
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject private var viewModel = RegisterUserViewModel()
    
    @State private var isPasswordShow: Bool = false
    @State private var isConfirmedPasswordShow: Bool = false
    
    @State var loading = false
    @State var error = false
    
    @State private var keyboardHeight: CGFloat = 0.0
    
    func signUp () {
        loading = true
        error = false
        /*session.signUp(email: viewModel.email, password: viewModel.password, username: viewModel.username) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            }
        }*/
        session.signUp(email: viewModel.email, password: viewModel.password, username: viewModel.username)/* {
            (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            }
        }*/
        /*let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = viewModel.username
        session.session?.displayName = viewModel.username*/
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    .frame(width: UIScreen.main.bounds.width - 20, height: 400)
                    .shadow(radius: 5)

                //.offset(y: -40)
                
                VStack {
                    
                    FloatingLabelTextField(self.$viewModel.username, placeholder: "Full Name", editingChanged: { (isChanged) in}){
                        
                    }
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                    .autocapitalization(UITextAutocapitalizationType.none)
                    .textContentType(.name)
                    
                    FloatingLabelTextField(self.$viewModel.email, placeholder: "Email", editingChanged: { (isChanged) in}){
                        
                    }
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                    .autocapitalization(UITextAutocapitalizationType.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    
                    
                    FloatingLabelTextField(self.$viewModel.password, placeholder: "Password", editingChanged: { (isChanged) in}){
                        
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
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .keyboardType(.asciiCapable)
                        .textContentType(.newPassword)
                    
                    FloatingLabelTextField(self.$viewModel.confirmPassword, placeholder: "Confirm Password", editingChanged: { (isChanged) in}){
                        
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
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .keyboardType(.asciiCapable)
                        .textContentType(.newPassword)
                    
                }
                //.offset(y: 10)
                
                
                Button(action: {
                    self.endEditing(true)
                    // SignUp with firebase
                    self.signUp()
                    if(self.session.session != nil){
                        let message = MDCSnackbarMessage()
                        message.text = "Register Successfully"
                        message.duration = 2
                        MDCSnackbarManager.show(message)
                        self.shouldPopToRootView = false
                        self.isMenuActive = false
                    }
                }) {
                    Text("SIGN UP")
                        .foregroundColor(Color("uwyellow"))
                        .frame(width: UIScreen.main.bounds.width - 150, height: 40.0)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .disabled(!self.viewModel.isValid)
                .offset(y: 385)
                
                
                Text("Register")
                    .font(.custom("Avenir Next Demi Bold", size:30))
                    .offset(x: -100,y: -20)
                
                VStack(alignment: .leading){
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Text(self.viewModel.userNameError ?? "")
                        .frame(height: 20)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    Spacer()
                        .frame(height: 65)
                    
                    Text(self.viewModel.emailError ?? "")
                        .frame(height: 20)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    Spacer()
                        .frame(height: 70)
                    
                    Text(self.viewModel.passwordError ?? "")
                        .frame(width: 300, height: 60)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text(self.viewModel.confirmPasswordError ?? "")
                        .frame(height: 20)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    
                    Spacer()
                        .frame(width:300, height: 10)
                    
                }
            }
            .offset(y: -self.keyboardHeight)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                    (notification) in
                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                        CGRect else {
                            return
                    }
                    
                    self.keyboardHeight = keyboardFrame.height - geo.size.height / 3
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                    (notification) in
                    
                    self.keyboardHeight = 0
                }
            }
                
        }

    }
}


/*struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}*/
