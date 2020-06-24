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
    let cardid : Int
    let id: Int
    @EnvironmentObject var model : Model
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    var fontSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(25)
        } else {
            return CGFloat(15)
        }
    }
    
    var boxSize: CGFloat {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.7 {
            return CGFloat(30)
        } else {
            return CGFloat(20)
        }
    }
    

    var body: some View {
        
        Button(action:{
            
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.model.cards[self.cardid].checkedBoxes.contains(self.id) ? "checkmark.square.fill" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.boxSize, height: self.boxSize)
                Text(model.cards[self.cardid].items[self.id])
                    .font(.custom("Avenir Next Medium", size:self.fontSize))
                    .foregroundColor(Color.black)
                    .minimumScaleFactor(0.01)
                    .lineLimit((model.cards[self.cardid].items[self.id].count <= 9) ? 1 : 2)
                    .multilineTextAlignment(.leading)
                Spacer()
            
            }
        }
        .highPriorityGesture(
            TapGesture().onEnded{
                self.checkboxSelected()
        })
    }
    
    func checkboxSelected() {
        if self.model.cards[self.cardid].checkedBoxes.contains(self.id) {
            model.cards[cardid].checkedBoxes.remove(at: model.cards[cardid].checkedBoxes.firstIndex(of: self.id)!)
        } else {
            self.model.cards[cardid].checkedBoxes.append(self.id)
            if (model.cards[cardid].checkedBoxes.count > model.cards[cardid].num) {
                model.cards[cardid].checkedBoxes.remove(at: 0)
            }
        }
        model.changed = true
        model.cards[cardid].progress = model.cards[cardid].checkedBoxes.count * 100 / model.cards[cardid].num
        self.generator.impactOccurred()
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    
    static var previews: some View {
        CheckBoxView(cardid: 0, id: 0)
        .environmentObject(Model())
    }
}

