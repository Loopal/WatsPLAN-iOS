//
//  ListItemView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct ListItemView: View {
    @EnvironmentObject var model : Model
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
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(30)
        } else {
            return CGFloat(20)
        }
    }
    
    var body: some View {
        return VStack(spacing: 0) {
            ZStack() {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 20, height: fontSize + 12)
                Text(cardText)
                    .font(.custom("Avenir Next Medium", size:fontSize))
                    .foregroundColor(Color("uwyellow"))
                
                ProgressCircle(id: self.id)
                    .offset(x :UIScreen.main.bounds.width/2 - 30)
            }
            
            if model.cards[id].items.max(by: {$1.count > $0.count})!.count >= 23 {
                GridView(id: self.id, colNum: 1)
            }
            else if model.cards[id].items.count >= 3 {
                GridView(id: self.id, colNum: 3)
            } else {
                GridView(id: self.id, colNum: model.cards[id].items.count)
            }
            
                        
            if(self.model.cards[id].num != 1) {
                TextField("My selection is ...", text: $model.cards[id].comment)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .font(.custom("Avenir Next Medium", size:fontSize - 8))
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
        VStack(alignment: .leading) {
            ForEach(([Int](0..<self.model.cards[id].items.count)).chunked(into: self.colNum), id: \.self) { chunk in
                HStack {
                    ForEach(chunk) { pos in
                        CheckBoxView(cardid: self.id, id: pos)
                    }
                }
            }
        }
        .padding(.leading, 10)
        .padding(.vertical, 10)
        .frame(width: UIScreen.main.bounds.width-20)
        .background(Color("uwyellow"))

    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
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
