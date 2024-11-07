//
//  PrimaryGradientBackground.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct PrimaryGradientBackground: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    private let lightModeGradient = Gradient(
        colors: [
            .bbPersian.opacity(0.5),
            .bbForestGreen.opacity(0.5),
        ]
    )
    
    private let darkModeGradient = Gradient(
        colors: [
            .bbPersian.opacity(0.4),
            .bbForestGreen.opacity(0.5),
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
