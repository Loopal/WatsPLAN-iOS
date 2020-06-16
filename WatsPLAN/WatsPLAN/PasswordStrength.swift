//
//  PasswordStrength.swift
//  CoolLoginScreens
//
//  Created by Hitesh Agarwal on 09/02/20.
//  Copyright © 2020 Hitesh Agarwal. All rights reserved.
//

import Foundation

func passwordStrengthChecker(forPassword text: String) -> PasswordValidation {
    
    let range = NSRange(location: 0, length: text.utf16.count)
    let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
    
    if(regex.firstMatch(in: text, options: [], range: range) != nil) {
        return .veryStrong
    }
    else{
        return .veryWeak
    }
    
    /*let entropy = text.count
    if entropy < 4 {
        return .veryWeak
    } else if entropy <= 6 {
        return .weak
    } else if entropy < 8 {
        return .reasonable
    } else if entropy < 10 {
        return .strong
    } else {
        return .veryStrong
    }*/
}

public enum PasswordValidation {
    case veryWeak
    case weak
    case reasonable
    case strong
    case veryStrong
    case empty
    case confirmPasswordEmpty
    case notMatch
    
    var errorMessage: String? {
        switch self {
        case .veryWeak:
            return "Password should be Minimum Eight Characters, at Least One Letter, One Number and One Special Character"
        case .empty:
            return "Please enter password"
         default:
            return nil
        }
    }
    
    var confirmPasswordErrorMessage: String? {
        switch self {
        case .confirmPasswordEmpty:
            return "Please enter confirm password"
        case .notMatch:
            return "Password not match"
        default:
            return nil
        }
    }
}

public enum UsernameValidation {
    case emptyUsername
    case inValidUsername
    case validUsername
    var errorMessage: String? {
        switch self {
        case .emptyUsername:
            return "Please enter username"
        case .inValidUsername:
            return "Invalid username"
        case .validUsername:
            return nil
        }
    }
}

public enum EmailValidation {
    case emptyEmail
    case inValidEmail
    case validEmail
    var errorMessage: String? {
        switch self {
        case .emptyEmail:
            return "Please enter email"
        case .inValidEmail:
            return "Invalid email"
        case .validEmail:
            return nil
        }
    }
}
