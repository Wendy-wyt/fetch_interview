//
//  Item.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
