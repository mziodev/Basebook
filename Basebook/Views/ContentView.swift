//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber: String = ""
    @State private var radix: Radix = .decimal
    @State private var conversions: [(String, String)] = []
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var keyboardType: UIKeyboardType {
        (
            radix == .duodecimal || radix == .hexadecimal
        ) ? .numbersAndPunctuation : .numberPad
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .trailing) {
                    TextField("0", text: $inputNumber)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 50))
                        .focused($isTextFieldFocused)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(.never)
                    
                    Text("\(radix.name) base")
                        .font(.caption.smallCaps())
                        .bold()
                        .foregroundStyle(.secondary)
                    
                    Picker("Select a base", selection: $radix) {
                        ForEach(Radix.allCases, id: \.self) {
                            Text($0.numberName)
                        }
                    }
                    .pickerStyle(.palette)
                    .onChange(of: radix) { oldValue, newValue in
                        if newValue.type != oldValue.type {
                            isTextFieldFocused = false
                            
                            DispatchQueue.main
                                .asyncAfter(deadline: .now() + 0.1) {
                                    isTextFieldFocused = true
                                }
                        }
                    }
                    
                    HStack(spacing: 30) {
                        Spacer()
                        
                        Button("Clear", role: .destructive) {
                            withAnimation {
                                inputNumber = ""
                                conversions = []
                            }
                        }
                        .frame(width: 100, height: 33)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        
                        Button("Convert") {
                            withAnimation {
                                getConversions()
                            }
                        }
                        .frame(width: 100, height: 33)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding([.top, .horizontal])
                
                List {
                    Section("Conversions") {
                        ForEach(conversions, id: \.0) {
                            name,
                            value in
                            HStack {
                                Text(name)
                                    .font(.headline)
                                    .foregroundStyle(
                                        name == radix.numberName ? Color.accentColor : .primary
                                    )
                                
                                Spacer()
                                
                                Text(value)
                                    .font(.title)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(
                                        name == radix.numberName ? Color.accentColor : .primary
                                    )
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Basebook")
        }
    }
    
    private func getConversions() {
        if !conversions.isEmpty { conversions = [] }
        
        let decimalInputNumber = getDecimalInputNumber()

        if decimalInputNumber == 0 { return }
        
        Radix.allCases.forEach { radix in
            let conversionValue = RadixConverter.convert(
                decimalInputNumber,
                to: radix.value
            )
            
            conversions.append((radix.numberName, conversionValue))
        }
    }
    
    private func getDecimalInputNumber() -> Int {
        if radix == .decimal {
            return Int(inputNumber) ?? 0
        } else {
            return RadixConverter.convert(
                inputNumber,
                from: radix.value
            ) ?? 0
        }
    }
}

#Preview {
    ContentView()
}
