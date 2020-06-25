//
//  MenuView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import MaterialComponents.MaterialSnackbar
import FirebaseAuth
import StatusBarColorKit

struct MenuView: View {
    
    @State var isActive: Bool = false
    
    @State var isTermActive: Bool = false
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var isMenuActive: Bool
    
    func getUser() {
        session.listen()
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
                .frame(height: 10)
            
            Image("uwlogo")
                .resizable()
                .aspectRatio(contentMode: .fit)

            NavigationLink(destination: LoginView(shouldPopToRootView: self.$isActive, isMenuActive: self.$isMenuActive), isActive: self.$isActive) {
                HStack {
                    Image("login")
                        .imageScale(.large)
                        .foregroundColor(Color("uwyellow"))
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 30)
                }
            }
            .isDetailLink(false)
            .padding(.top, 10)
            .disabled(self.session.session != nil)
            .simultaneousGesture(TapGesture().onEnded{_ in
                if(self.session.session != nil){
                    let message = MDCSnackbarMessage()
                    //message.text = "Currently Login with " + (Auth.auth().currentUser?.displayName)!
                    message.text = "Currently Login with " + (self.session.session?.displayName)!
                    message.duration = 2
                    MDCSnackbarManager.show(message)
                }
            })
            
            /*HStack {
                Image("home")
                    .imageScale(.large)
                Text("Home")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 30)

            }
            .padding(.top, 10)
            HStack {
                Image("dev")
                    .imageScale(.large)
                Text("Dev")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 30)

            }
            .padding(.top, 10)*/
            
            Button(action: {
                let result = self.session.signOut()
                let message = MDCSnackbarMessage()
                message.duration = 2
                if(result){
                    message.text = "Log out Successfully"
                }
                else{
                    message.text = "Unable to Log out"
                }
                MDCSnackbarManager.show(message)
            }) {
                HStack {
                    Image("logout")
                        .imageScale(.large)
                        .foregroundColor(Color("uwyellow"))
                    Text("Log out")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 30)
                }
                .padding(.top, 10)
            }
            
            
            NavigationLink(destination: TermAndConditionView(shouldPopToRootView: self.$isTermActive, isMenuActive: self.$isMenuActive), isActive: self.$isTermActive) {
                HStack {
                    Image("term")
                        .imageScale(.large)
                        .foregroundColor(Color("uwyellow"))
                    Text("Terms and Conditions")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 30)
                }
            }
            .isDetailLink(false)
            .padding(.top, 10)
            
            
            /*HStack {
                Image("term")
                    .imageScale(.large)
                Text("Terms and Conditions")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 30)
            }
            .padding(.top, 10)*/
            Spacer()
        }
        .onAppear(perform: getUser)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

/*struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
        .environmentObject(SessionStore())
    }
}*/
