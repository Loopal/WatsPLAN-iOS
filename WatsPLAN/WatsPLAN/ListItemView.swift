//
//  ListItemView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import QGrid

let minHeight = 50

struct ListItemView: View {
    @EnvironmentObject var model : Model
    @State private var comment: String = ""
    var id : Int
    var cardText: String {
        if model.cards[id].items.count >= 3 {
            if (model.cards[id].num == model.cards[id].items.count) {
                return "Select All From " + model.cards[id].text
            } else {
                return "Select " + String(model.cards[id].num) + " From " + model.cards[id].text
            }
        } else {
            return "Select " + model.cards[id].text
        }
    }
    var body: some View {
        return VStack(spacing: 0) {
            ZStack() {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 32)
                Text(cardText)
                    .font(.custom("Avenir Next Medium", size:20))
                    .foregroundColor(Color("uwyellow"))
                
                ProgressCircle(id: self.id)
                    .offset(x :UIScreen.main.bounds.width/2 - 30)
            }
            
            if model.cards[id].items.max(by: {$1.count > $0.count})!.count >= 22 {
                GridView(id: self.id, colNum: 1)
            }
            else if model.cards[id].items.count >= 3 {
                GridView(id: self.id, colNum: 3)
            } else {
                GridView(id: self.id, colNum: model.cards[id].items.count)
            }
            
                        
            if(self.model.cards[id].num != 1) {
                TextField("My selection is ...", text: $comment)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .font(.custom("Avenir Next Medium", size:12))
                    .background(Color("uwyellow"))
            }
        }
        .offset(x: -5)
    }
    
}


struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(id: 0)
        .environmentObject(Model())
    }
}


struct GridView: View {
    var id: Int
    var colNum: Int
    @EnvironmentObject var model : Model

    var body: some View {
        
        QGrid([Int](0..<self.model.cards[id].items.count), columns: colNum) { pos in
            CheckBoxView(cardid: self.id, id: pos,pad : self.colNum < 3 || self.model.cards[self.id].items[pos].count < 7)
            //Text(String(self.colNum))
        }
        .frame(width: UIScreen.main.bounds.width-20, height: getHeight(columns: self.colNum, items: model.cards[id].items))
        .background(Color("uwyellow"))
         
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

func getHeight(columns: Int, items : [String]) ->CGFloat {
    var h = 0
    var c = 0
    while c < items.count {
        var temp = items[c].count
        var col = 1
        while col < columns && c+col < items.count {
            temp = items[c+col].count > temp ? items[c+col].count : temp
            col += 1
        }
        if columns == 3 {
            h += 40 + temp / 7 * 10
        } else if columns == 2 {
            h += 35 + temp
        } else {
            h += 35 + temp / 20 * 10
        }
        c += columns
    }
    return CGFloat(h)
}


struct ProgressCircle: View {
    var id: Int
    @EnvironmentObject var model : Model

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 20, height: 20)
                Circle()
                    .trim(from: 0.0, to: CGFloat(self.model.cards[self.id].progress) / 100)
                    .stroke(Color.green, lineWidth: 4)
                    .frame(width: 20, height: 20)
                    .rotationEffect(Angle(degrees: -90))
            }
        }
        .frame(width: 20, height: 20)
    }

}
