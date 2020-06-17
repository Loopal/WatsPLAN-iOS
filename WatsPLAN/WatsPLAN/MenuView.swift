//
//  MenuView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @State var isActive: Bool = false
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var isMenuActive: Bool
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
            .disabled(self.session.session == nil)
            HStack {
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
            .padding(.top, 10)
            
            Button(action: {
                let result = self.session.signOut()
                if(result){
                    print("Log out successfully")
                }
                else{
                    print("Log out fail")
                }
            }) {
                HStack {
                    Image("logout")
                        .imageScale(.large)
                    Text("Log out")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 30)
                }
                .padding(.top, 10)
            }
            
            
            HStack {
                Image("term")
                    .imageScale(.large)
                Text("Terms and Conditions")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 30)
            }
            .padding(.top, 10)
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
