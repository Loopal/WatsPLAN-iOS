//
//  LoginView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-13.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("logo")
                .resizable()
                .frame(width: 200.0, height: 200.0)
            Text("LOGIN")
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
