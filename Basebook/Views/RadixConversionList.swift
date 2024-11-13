//
//  RadixConversionList.swift
//  Basebook
//
//  Created by MZiO on 13/11/24.
//

import SwiftUI

struct RadixConversionList: View {
    let radixConversionSet: RadixConversionSet
    
    var body: some View {
        List {
            if !radixConversionSet.radixConversions.isEmpty {
                Section {
                    ForEach(
                        radixConversionSet.radixConversions,
                        id:\.radix
                    ) { radixConversion in
                        ListRow(
                            currentRadix: radixConversion.radix,
                            selectedRadix: radixConversionSet.selectedRadix,
                            value: radixConversion.value
                        )
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    HistoryListSectionHeader(
                        title: String(localized: "Conversions")
                    )
                }
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .padding(.bottom)
        .overlay {
            if radixConversionSet.radixConversions.isEmpty {
                RadixConversionListEmpty()
            }
        }
    }
}

#Preview {
    RadixConversionList(radixConversionSet: SampleData.shared.radixConversionSet)
}
