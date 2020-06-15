//
//  LoginModel.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-15.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import ValidatedPropertyKit

class LoginModel: ObservableObject {
    
    @Validated(.isEmail)
    var email: String?
    @Validated(.nonEmpty)
    var password: String?
}
