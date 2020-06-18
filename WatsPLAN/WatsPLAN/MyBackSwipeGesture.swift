//
//  MyBackGesture.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-18.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
