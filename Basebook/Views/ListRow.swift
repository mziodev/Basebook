//
//  ListRow.swift
//  Basebook
//
//  Created by MZiO on 29/10/24.
//

import SwiftUI

struct ListRow: View {
    let currentRadix: Radix
    let selectedRadix: Radix
    let value: String
    
    private var textColor: Color {
        currentRadix == selectedRadix ? Color.accentColor : .primary
    }
    
    private var textColorInverted: Color {
        currentRadix != selectedRadix ? Color.accentColor : .primary
    }
    
    var body: some View {
        HStack {
            Text(currentRadix.localizedName)
                .font(.headline)
                .foregroundStyle(textColor)
            
            Spacer()
            
            HStack(alignment: .bottom, spacing: 2) {
                Text(value)
                    .font(.title)
                    .fontDesign(.rounded)
                    .foregroundStyle(textColor)
                
                Text(currentRadix.numberName)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .foregroundStyle(textColorInverted)
                
            }
        }
    }
}

#Preview("Different Radix") {
    List {
        ListRow(currentRadix: .decimal, selectedRadix: .binary, value: "1234")
    }
}

#Preview("Same Radix") {
    List {
        ListRow(currentRadix: .decimal, selectedRadix: .decimal, value: "1234")
    }
}
