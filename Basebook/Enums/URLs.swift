//
//  URLs.swift
//  Basebook
//
//  Created by MZiO on 17/12/24.
//

import Foundation

/// A collection of static URLs used throughout the application.
///
/// This enum contains various URLs that are utilized for different purposes,
/// such as contacting support, accessing the privacy policy, reviewing terms of use,
/// and writing reviews on the App Store.
enum URLs {
    
    /// The email address for contacting support or feedback.
    static let email = URL(string: "mailto:mziodev@gmail.com")!
    
    /// The URL to the privacy policy of the application.
    static let privacyPolicy = URL(
        string: "https://mziodev.github.io/apps/Basebook/privacy-policy.html"
    )!
    
    /// The URL to the terms of use for the application.
    static let termsOfUse = URL(
        string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
    )!
    
    /// The URL to write a review for the application on the App Store.
    static let writeReview = URL(
        string: "itms-apps://itunes.apple.com/app/id6737809008?action=write-review"
    )!
}
