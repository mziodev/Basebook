//
//  RadixSelector.swift
//  Basebook
//
//  Created by MZiO on 13/11/24.
//

import SwiftUI

struct RadixSelector: View {
    @Binding var radixConversionSet: RadixConversionSet
    @Binding var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(radixConversionSet.selectedRadix.localizedName) base")
                .font(.callout.smallCaps())
                .foregroundStyle(.accent)
            
            Picker("Select a base", selection: $radixConversionSet.selectedRadix) {
                ForEach(Radix.allCases, id: \.self) {
                    Text($0.numberName)
                }
            }
            .pickerStyle(.palette)
            .onChange(of: radixConversionSet.selectedRadix) { oldvalue, newValue in
                updateKeyboardTypeOnRadixChange(
                    oldValue: oldvalue,
                    newValue: newValue
                )
            }
        }
    }
    
    private func updateKeyboardTypeOnRadixChange(oldValue: Radix, newValue: Radix) {
        if isTextFieldFocused {
            if newValue.keyboardType != oldValue.keyboardType {
                isTextFieldFocused = false
                
                DispatchQueue.main
                    .asyncAfter(deadline: .now() + 0.1) {
                        isTextFieldFocused = true
                    }
            }
        }
    }
}

#Preview {
    RadixSelector(
        radixConversionSet: .constant(SampleData.shared.radixConversionSet),
        isTextFieldFocused: .constant(true)
    )
}
