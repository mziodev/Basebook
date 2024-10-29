//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputNumber: String = ""
    @State var radix: Radix = .decimal
    @State var conversions: [(String, String)] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        TextField("0", text: $inputNumber)
                            .multilineTextAlignment(.trailing)
                            .font(.title)
                        
                        Picker("Select a base", selection: $radix) {
                            ForEach(Radix.allCases, id: \.self) {
                                Text($0.name)
                            }
                        }
                    }
                    
                    HStack(spacing: 30) {
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
                                        name == radix.name ? Color.accentColor : .primary
                                    )
                                
                                Spacer()
                                
                                Text(value)
                                    .font(.title)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(
                                        name == radix.name ? Color.accentColor : .primary
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
            
            conversions.append((radix.name, conversionValue))
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
