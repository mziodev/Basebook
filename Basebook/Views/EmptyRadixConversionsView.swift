//
//  EmptyRadixConversionsView.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import SwiftUI

struct EmptyRadixConversionsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var basebookBackgroundImage: String {
        colorScheme == .light ? "BasebookLogoBackgroundLight" : "BasebookLogoBackgroundDark"
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(basebookBackgroundImage)
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .opacity(0.9)
                .accessibilityLabel("Basebook logo with an hexagons circle")
            
            Text("Select a base, tap on the big zero and introduce a number to convert :)")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    EmptyRadixConversionsView()
}
