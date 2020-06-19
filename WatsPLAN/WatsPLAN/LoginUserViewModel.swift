//
//  LoginUserViewModel.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-15.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoginUserViewModel: ObservableObject {
    
    @Published var email: String = "".trimmingCharacters(in: .whitespacesAndNewlines)
    @Published var password: String = "".trimmingCharacters(in: .whitespacesAndNewlines)
    @Published var emailValidator = EmailValidation.emptyEmail
    @Published var passwordValidator = PasswordValidation.empty
    @Published var isValid: Bool = false
    @Published var emailError: String?
    @Published var passwordError: String?
    
    private var cancellableSet: Set<AnyCancellable> = []
    init() {
        Publishers.CombineLatest( self.emailValidatorPublisher, self.passwordValidatorPublisher)
            .dropFirst()
            .sink {_emailError, _passwordValidator in
                
                self.isValid = _emailError == nil &&
                    _passwordValidator.errorMessage == nil
        }
        .store(in: &cancellableSet)
        
        emailValidatorPublisher
            .dropFirst()
            .sink { (_emailError) in
                self.emailError = _emailError
                }
            .store(in: &cancellableSet)
        
        passwordValidatorPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
            self.passwordError = _passwordValidator.errorMessage
            }
            .store(in: &cancellableSet)
    }
    
    
    private var emailValidatorPublisher: AnyPublisher<String?, Never> {
        
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _email in
                if _email.isEmpty {
                    return "Please enter email"
                } else if !_email.isValidEmail {
                    return "Please enter valid email"
                } else {
                    return nil
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var passwordValidatorPublisher: AnyPublisher<PasswordValidation, Never> {
        $password
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                if password.isEmpty {
                    return .empty
                } else {
                    return PasswordValidation.veryStrong
                }
        }
        .eraseToAnyPublisher()
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

