//
//  MenuView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("uwlogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            NavigationLink(destination: LoginView()) {
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
            .padding(.top, 10)
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
            HStack {
                Image("logout")
                    .imageScale(.large)
                Text("Log out")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 30)
            }
            .padding(.top, 10)
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
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
