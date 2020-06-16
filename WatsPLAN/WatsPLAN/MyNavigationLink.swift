//
//  MyNavigationLink.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-16.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation
import SwiftUI


/// Fixed swipe gesture NavigationLink
struct MyNavigationLink<Destination: View, Label:View>: View {
    var destination: Destination
    var label: () -> Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    /// If this crashes, make sure you wrapped the NavigationLink in a NavigationView
    @EnvironmentObject private var nvc: NavigationViewUINavigationController
    
    var body: some View {
        Button(action: {
            let rootView = self.destination.environmentObject(self.nvc)
            let hosted = UIHostingController(rootView: rootView)
            self.nvc.pushViewController(hosted, animated: true)
        }, label: label)
    }
}

/// Fileprivate type to not expose the navigation controller to all views
fileprivate class NavigationViewUINavigationController: UINavigationController, ObservableObject {}
