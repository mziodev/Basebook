//
//  View+Gradient.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

extension View {
    
    func primaryGradientBackground() -> some View {
        modifier(PrimaryGradientBackground())
    }
    
    func secondaryGradientBackground() -> some View {
        modifier(SecondaryGradientBackground())
    }
}
