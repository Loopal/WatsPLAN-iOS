//
//  FloatingTextField.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import SkyFloatingLabelTextField

struct FloatingTextField: UIViewRepresentable {
    
    let x, y, width, height: Int
    let placeholder, title: String
    let secure: Bool
    @Binding var text: String
    
    /*init(x: Int, y: Int, width: Int, height: Int, placeholder: String, title: String){
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.placeholder = placeholder
        self.title = title
    }*/
    
    let textField = SkyFloatingLabelTextField()
    
    func makeUIView(context: Context) -> UITextField {
        
        textField.frame = CGRect(x: x, y: y, width: width, height: height)
        textField.placeholder = placeholder
        textField.title = title
        textField.isSecureTextEntry = secure
        textField.delegate = context.coordinator
        
        /*let textField = SkyFloatingLabelTextField(frame: CGRect(x: x, y: y, width: width, height: height))*/
        /*textField.frame = CGRect(x: x, y: y, width: width, height: height)
        textField.placeholder = placeholder
        textField.title = title*/
        /*if(secure) {
            textField.isSecureTextEntry = true
        }*/
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        // = uiView.text!
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        
        init(_ text: Binding<String>) {
            self.text = text
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.text.wrappedValue = textField.text!
        }
        
        
    }
    
}
