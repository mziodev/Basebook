//
//  EmptyConversions.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import SwiftUI

struct EmptyConversions: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "circle.hexagonpath.fill")
                .font(.system(size: 120))
                .foregroundColor(.accentColor.opacity(0.7))
            
            Text("Select a base, tap on the big zero and introduce a number to convert :)")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding(40)
        .padding(.bottom, 80)
    }
}

#Preview {
    EmptyConversions()
}
