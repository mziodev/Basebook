//
//  URL.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import Foundation

class BasebookURL {
    static let email = URL(string: "mailto:mziodev@gmail.com")!
    
    static let privacyPolicy = URL(
        string: "https://mziodev.github.io/apps/Basebook/privacy-policy.html"
    )!
    
    static let termsOfUse = URL(
        string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
    )!
    
    static let writeReview = URL(
        string: "itms-apps://itunes.apple.com/app/id6737809008?action=write-review"
    )!
}
