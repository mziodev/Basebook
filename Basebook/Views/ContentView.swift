//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber: String = ""
    @State private var selectedRadix: Radix = .decimal
    @State private var conversions: [(Radix, String)] = []
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .trailing) {
                    TextField("0", text: $inputNumber)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 60))
                        .fontDesign(.rounded)
                        .focused($isTextFieldFocused)
                        .keyboardType(selectedRadix.keyboardType)
                        .textInputAutocapitalization(.never)
                    
                    Text("\(selectedRadix.name) base")
                        .font(.callout.smallCaps())
                        .foregroundStyle(.accent)
                    
                    Picker("Select a base", selection: $selectedRadix) {
                        ForEach(Radix.allCases, id: \.self) {
                            Text($0.numberName)
                        }
                    }
                    .pickerStyle(.palette)
                    .onChange(of: selectedRadix) { oldValue, newValue in
                        clearTextField()

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
                    
                    HStack(spacing: 30) {
                        Spacer()
                        
                        Button("Clear", role: .destructive) {
                            clearTextField()
                        }
                        .frame(width: 100, height: 33)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        
                        Button("Convert") {
                            withAnimation {
                                fillConversions()
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
                    if !conversions.isEmpty {
                        Section {
                            ForEach(conversions, id: \.0) { radix, value in
                                ListRow(
                                    currentRadix: radix,
                                    selectedRadix: selectedRadix,
                                    value: value
                                )
                                .listRowBackground(Color.clear)
                            }
                        } header: {
                            Text("Conversions")
                                .font(.callout.smallCaps())
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .padding(.bottom)
                .overlay {
                    if conversions.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "circle.hexagonpath.fill")
                                .font(.system(size: 120))
                                .foregroundColor(.accent.opacity(0.4))
                            
                            Text("Select a base and tap on the big zero for introduce a number to convert :)")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .padding(40)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Basebook")
            .background(
                Gradient(colors: [.accent.opacity(0.2), .accent.opacity(0.5)])
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90") {
                        // show history
                    }
                }
            }
        }
    }
    
    private func clearTextField() {
        withAnimation {
            inputNumber = ""
            conversions = []
        }
    }
    
    private func fillConversions() {
        if inputNumber == "0" || inputNumber.isEmpty { return }
        
        if !conversions.isEmpty { conversions.removeAll(keepingCapacity: true) }
        
        guard let decimalInputNumber = RadixConverter.convert(
            inputNumber,
            from: selectedRadix.value
        ) else { return }
        
        conversions = ConversionsViewModel.getConversions(
            for: decimalInputNumber
        )
        
        isTextFieldFocused = false
    }
}

#Preview {
    ContentView()
}
