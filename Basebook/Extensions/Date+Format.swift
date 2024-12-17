//
//  Date+Format.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import Foundation

extension Date {
    
    /// A string representation of the date formatted to show the month and day.
    ///
    /// This property returns the month and day of the date in a formatted
    /// string, with the day displayed as a two-digit number. For example, if
    /// the date is March 5, 2023, this property will return "March 05".
    var monthAndDay: String {
        self.formatted(.dateTime.month().day(.twoDigits))
    }
    
    /// A string representation of the year extracted from the date.
    ///
    /// This property returns the year of the date as a string. For example,
    /// if the date is March 5, 2023, this property will return "2023".
    var year: String {
        self.formatted(.dateTime.year())
    }
}
