//
//  ListItemView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import QGrid

let minHeight = 40

struct ListItemView: View {
    
    var card : Card
    var body: some View {
        return VStack(spacing: 0) {
            ZStack() {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 350, height: 32)
                Text(card.text)
                    .font(.custom("Avenir Next Medium", size:25))
                .foregroundColor(Color("uwyellow"))
                
                ProgressCircle(process: CGFloat(card.progress))
                    .offset(x :160)
            
            }
            /*
            List(card.items, id: \.self) { item in
                CheckBoxView(id: item, label: item, callback: checkboxSelected)
                }.colorMultiply(Color("uwyellow"))

            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
            .onDisappear { }
            .frame(width: 350, height : CGFloat(minHeight * card.items.count))
            */
            GridView(card: card, colNum: 3)
                .frame(width: 350, height : CGFloat(20 + minHeight * card.items.count / 3 ))
                .background(Color("uwyellow"))
            



            if(card.num > 1) {
                TextField("My selection is ...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.all, 10)
                    .frame(width: 350)
                    .font(.custom("Avenir Next Medium", size:12))
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

struct GridView: View {
    var card: Card
    var colNum: Int
    
    var body: some View {
        QGrid(card.items, columns: colNum) { item in
            CheckBoxView(id: item, label: item, callback: checkboxSelected)
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}


struct ProgressCircle: View {
    @State var process: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 20, height: 20)
                Circle()
                    .trim(from: 0.0, to: 0.5)
                    .stroke(Color.green, lineWidth: 4)
                    .frame(width: 20, height: 20)
                    .rotationEffect(Angle(degrees: -90))
            }
        }
        .frame(width: 20, height: 20)
    }

}
