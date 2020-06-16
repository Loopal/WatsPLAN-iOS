//
//  User.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-16.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
