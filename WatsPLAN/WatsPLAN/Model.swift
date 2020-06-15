//
//  Model.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-14.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import Foundation

class Model: ObservableObject {
    @Published var facultyName = ""
    @Published var majorName = ""
    @Published var fileName = ""
    @Published var changed = false
    @Published var storedCards: [Card] = []
    @Published var cards: [Card] = []
}
