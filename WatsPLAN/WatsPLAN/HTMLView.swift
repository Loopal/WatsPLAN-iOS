//
//  HTMLView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-21.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    
    @Binding var htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}
