//
//  Date+Format.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import Foundation

extension Date {
    var monthAndDay: String {
        self.formatted(.dateTime.month().day(.twoDigits))
    }
    
    var year: String {
        self.formatted(.dateTime.year())
    }
}
