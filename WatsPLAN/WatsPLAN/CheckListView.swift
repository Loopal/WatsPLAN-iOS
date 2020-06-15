//
//  CheckListView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct CheckListView: View {
    var cards : [Card]
    var storedCards : [Card]
    var body: some View {
        return VStack(spacing : 0) {
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 110)

                Image("math_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 10.0)
            
            }
            Text("Place holder")
                .font(.custom("Avenir Next Medium", size:15))
                .background(Color.black)
                .foregroundColor(Color.white)



            List(cards) { card in
                ListItemView(card: card)
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = .clear
            }

        }

        
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(cards : [Card(id : 0, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])], storedCards: [Card(id : 0, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",]), Card(id : 1, text: "Some Text",items : ["CS136", "CS136","CS136","CS136",])])
    }
}
