//
//  CheckBoxView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI



//MARK:- Checkbox Field
struct CheckBoxView: View {
    let id: String
    let label: String
    let size: CGFloat
    let textSize: Int
    let callback: (String, Bool)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 15,
        color: Color = Color.black,
        textSize: Int = 15,
        callback: @escaping (String, Bool)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.textSize = textSize
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square.fill" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                    .foregroundColor(Color.black)
            }
        }
    }
}
struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(id: "a",
        label: "Test Course",
        size: 20,
        textSize: 20,
        callback: checkboxSelected)
    }
}
