//
//  RadixConversionsListRow.swift
//  Basebook
//
//  Created by MZiO on 29/10/24.
//

import SwiftUI

struct RadixConversionsListRow: View {
    let currentRadix: Radix
    let selectedRadix: Radix
    let value: String
    
    var body: some View {
        HStack {
            Text(currentRadix.localizedName)
                .font(.headline)
                .foregroundStyle(
                    currentRadix == selectedRadix ? Color.accentColor : .primary
                )
            
            Spacer()
            
            HStack(alignment: .bottom, spacing: 2) {
                Text(value)
                    .font(.title)
                    .fontDesign(.rounded)
                    .foregroundStyle(
                        currentRadix == selectedRadix ? Color.accentColor : .primary
                    )
                
                Text(currentRadix.numberName)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .foregroundStyle(
                        currentRadix != selectedRadix ? .accent : .primary
                    )
                
            }
        }
    }
}

#Preview("Different Radix") {
    List {
        RadixConversionsListRow(currentRadix: .decimal, selectedRadix: .binary, value: "1234")
    }
}

#Preview("Same Radix") {
    List {
        RadixConversionsListRow(currentRadix: .decimal, selectedRadix: .decimal, value: "1234")
    }
}
