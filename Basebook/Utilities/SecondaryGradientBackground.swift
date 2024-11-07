//
//  SecondaryGradientBackground.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct SecondaryGradientBackground: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    private let darkModeGradient = Gradient(
        colors: [
            .bbForestGreen.opacity(0.5),
            .bbForestGreen.opacity(0.2)
        ]
    )
    
    private let lightModeGradient = Gradient(
        colors: [
            .bbForestGreen.opacity(0.2),
            .bbForestGreen.opacity(0.5)
        ]
    )
    
    private var gradient: Gradient {
        colorScheme == .dark ? darkModeGradient : lightModeGradient
    }

    func body(content: Content) -> some View {
        content
            .background(gradient)
    }
}
