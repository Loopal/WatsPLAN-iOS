//
//  ObservableObject.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 01/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
class FloatingLabelTextFieldNotifier: ObservableObject {
    
    //MARK: Views Properties
    @Published var leftView: AnyView?
    @Published var rightView: AnyView?
    
    //MARK: Alignment Properties
    @Published var textAlignment: TextAlignment = .leading
    
    //MARK: Line Properties
    @Published var lineHeight: CGFloat = 1
    @Published var selectedLineHeight: CGFloat = 1.5
    @Published var lineColor: Color = .black
    @Published var selectedLineColor: Color = .blue
    
    //MARK: Title Properties
    @Published var titleColor: Color = .gray
    @Published var selectedTitleColor: Color = .blue
    @Published var titleFont: Font = .system(size: 12)
    
    //MARK: Text Properties
    @Published var textColor: Color = .black
    @Published var selectedTextColor: Color = .blue
    @Published var font: Font = .system(size: 15)
    
    //MARK: Placeholder Properties
    @Published var placeholderColor: Color = .gray
    @Published var placeholderFont: Font = .system(size: 15)
    
    //MARK: Other Properties
    @Published var spaceBetweenTitleText: Double = 15
    @Published var isSecureTextEntry: Bool = false
}
