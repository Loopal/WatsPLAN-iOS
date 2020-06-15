//
//  Card.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation

struct Card: Codable, Identifiable {
    var id : Int
    var text = ""
    var done: Bool = false
    var checkedBoxes : [Int] = []
    var num = 0
    var progress = 0
    var items: [String] = []
    var comment = ""
}
