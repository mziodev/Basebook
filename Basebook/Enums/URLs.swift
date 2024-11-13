//
//  URLs.swift
//  Basebook
//
//  Created by MZiO on 13/11/24.
//

import Foundation

// namespace semantic enum (named in plural)
enum URLs {
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
