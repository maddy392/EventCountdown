//
//  Event.swift
//  EventCountdown
//
//  Created by Madhu Babu Adiki on 7/4/24.
//

import Foundation
import SwiftUI

struct Event: Comparable, Identifiable, Hashable {

    var id: String
    var title: String
    var date: Date
    var textColor: Color
    
    init(id: String = UUID().uuidString, title: String, textColor: Color, date: Date) {
        self.id = id
        self.title = title
        self.date = date
        self.textColor = textColor
    }
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}
