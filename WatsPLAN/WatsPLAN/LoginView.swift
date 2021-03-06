//
//  LoginView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import FirebaseAuth
import MaterialComponents.MaterialSnackbar
import StatusBarColorKit

struct LoginView: View {
    
    @Binding var shouldPopToRootView: Bool
    
    @Binding var isMenuActive: Bool
    
    var body: some View {
        
        GeometryReader { bounds in
            VStack() {
                
                /*if(bounds.size.height / bounds.size.width < 1.7){
                    Spacer()
                        .frame(height: bounds.size.height * 0.1)
                }*/
                
                Spacer()
                    .frame(height: (bounds.size.height / bounds.size.width < 1.7) ? bounds.size.height * 0.1 : bounds.size.height * 0.1)
                
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: bounds.size.height * 0.2)
                
                /*if(bounds.size.height / bounds.size.width < 1.7){
                    Spacer()
                        .frame(height: bounds.size.height * 0.1)
                }*/
                
                Spacer()
                    .frame(height: (bounds.size.height / bounds.size.width < 1.7) ? bounds.size.height * 0.1 : 0)
                
                LoginCard(shouldPopToRootView: self.$shouldPopToRootView, isMenuActive: self.$isMenuActive)
                    //.frame(height: bounds.size.height * 0.5)
                
                /*if(bounds.size.height / bounds.size.width < 1.7){
                    Spacer()
                        .frame(height: bounds.size.height * 0.1)
                }
                else{
                    Spacer()
                    .frame(height: bounds.size.height * 0.5)
                }*/
                
                
                Spacer()
                    .frame(height: (bounds.size.height / bounds.size.width < 1.7) ? bounds.size.height * 0.1 : 0)
                
                
                NavigationLink(destination: RegisterView(shouldPopToRootView: self.$shouldPopToRootView, isMenuActive: self.$isMenuActive)) {
                    Text("New Here? Create an Account")
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                //.frame(height: bounds.size.height * 0.3)
                
                /*if(bounds.size.height / bounds.size.width < 1.7){
                    Spacer()
                        .frame(height: bounds.size.height * 0.35)
                }*/
                
                Spacer()
                    .frame(height: (bounds.size.height / bounds.size.width < 1.7) ? bounds.size.height * 0.35 : bounds.size.height * 0.2)
                
            }
            //.navigationBarTitle("")
            //.navigationBarHidden(true)
        }
    }
}

struct LoginCard: View {
    
    @Binding var shouldPopToRootView: Bool
    
    @Binding var isMenuActive: Bool
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var viewModel = LoginUserViewModel()
    
    @State var loading = false
    @State var error = false
    
    @State private var keyboardHeight: CGFloat = 0.0
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: viewModel.email, password: viewModel.password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            }
        }
    }
    
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        GeometryReader { bounds in

            ZStack() {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("uwyellow"))
                    //.frame(width: bounds.size.width - 20, height: bounds.size.height)
                    .frame(maxWidth: 355)
                    .frame(height: 250)
                    .shadow(radius: 5)

                //.offset(y: -40)
                
                VStack {
                    /*FloatingLabelTextField($loginModel.email.bound, placeholder: "Email", editingChanged: { (isChanged) in}){
                    }*/
                    
                    /*FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in}){
                    }*/
                    
                    FloatingLabelTextField(self.$viewModel.email, placeholder: "Email", editingChanged: { (isChanged) in}){
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
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                    
                    /*FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in}){
                        
                    }*/
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
                        .keyboardType(.asciiCapable)
                        .textContentType(.password)
                    
                    /*NavigationLink(destination: ContentView(), tag: true, selection: session.$verified) {
                        Button(action: {
                            self.endEditing(true)
                            // SignIn with firebase
                            self.signIn()
                        }) {
                            Text("SIGN IN")
                                .foregroundColor(Color("uwyellow"))
                                .frame(width: 200.0, height: 30.0)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .disabled(!viewModel.isValid)
                        .offset(y: 55)
                    }*/
                    
                    Button(action: {
                        self.endEditing(true)
                        // SignIn with firebase
                        self.signIn()
                        if(self.session.session != nil){
                            let message = MDCSnackbarMessage()
                            message.text = "Login Successfully"
                            message.duration = 2
                            MDCSnackbarManager.show(message)
                            self.shouldPopToRootView = false
                            self.isMenuActive = false
                        }
                    }) {
                        Text("SIGN IN")
                            .foregroundColor(Color("uwyellow"))
                            .frame(width: (bounds.size.width < 355) ? bounds.size.width - 150 : 225, height: 40.0)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .disabled(!self.viewModel.isValid)
                    .offset(y: 55)
                    
                    
                    Text("LOGIN")
                        .font(.custom("Avenir Next Demi Bold", size:30))
                        //.font(.system(size: 500))
                        //.minimumScaleFactor(0.01)
                        //.frame(width: bounds.size.width * 0.25)
                        //.lineLimit(1)
                        //.offset(x: -bounds.size.width * 0.3, y: -bounds.size.height * 0.25)
                        //.font(.custom("Avenir Next Demi Bold", size:30))
                        .offset(x: (bounds.size.width < 355) ? -(bounds.size.width/2 - 75) : -112.5, y:-235)
                        //.font(.system(size: bounds.size.width * 0.3))
                }
                    
                
                VStack(alignment: .leading){
                    Spacer()
                        .frame(height: 10)
                    
                    Text(self.viewModel.emailError ?? "")
                        .frame(height: 20)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    Spacer()
                        .frame(width:300, height: 65)
                    
                    Text(self.viewModel.passwordError ?? "")
                        .frame(height: 20)
                    .foregroundColor(.red)
                    .font(.caption)
                }
            }
            .offset(y: (UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7) ? 0 : -self.keyboardHeight)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                    (notification) in
                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                        CGRect else {
                            return
                    }
                    
                    self.keyboardHeight = keyboardFrame.height - bounds.size.height / 4
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                    (notification) in
                    
                    self.keyboardHeight = 0
                }
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
/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}*/

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
