//
//  ListItemView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

let minHeight = 45

struct ListItemView: View {
    
    var card : Card
    var body: some View {
        VStack(spacing: 0) {
            ZStack() {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 350, height: 32)
                Text(card.text)
                    .font(.custom("Avenir Next Medium", size:25))
                .foregroundColor(Color("uwyellow"))
            }
            
            List(card.items, id: \.self) { item in
                CheckBoxView(id: item, label: item, callback: checkboxSelected)
                }.colorMultiply(Color("uwyellow"))

            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
            .onDisappear { }
            .frame(width: 350, height : CGFloat(minHeight * card.items.count))
            
            if(card.num > 1) {
                TextField("My selection is ...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.all, 10)
                    
                .frame(width: 350)
                .background(Color("uwyellow"))
            }

        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(card: Card(id : 0,text: "Some Text", num : 2,items : ["CS136", "CS136","CS136","CS136"]))
    }
}

func checkboxSelected(id: String, isMarked: Bool) {
    print("\(id) is marked: \(isMarked)")
}

