//
//  HistoryListRow.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import SwiftUI

struct HistoryListRow: View {
    let radixConversionSet: RadixConversionSet
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("From \(radixConversionSet.selectedRadix.localizedName.lowercased()) base")
                    .font(.headline)
                
                Text(radixConversionSet.date.monthAndDay)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(radixConversionSet.inputNumber)
                .font(.title)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
        }
        .contentShape(Rectangle()) // for getting tap gesture on the entire row
    }
}

#Preview {
    List {
        HistoryListRow(radixConversionSet: SampleData.shared.conversionSet)
    }
}
