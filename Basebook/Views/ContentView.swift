//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    @State private var inputNumber: String = ""
    @State private var selectedRadix: Radix = .decimal
    @State private var radixConversions: [RadixConversion] = []
    @State private var showingConversionAlert: Bool = false
    
    @State private var alertMessage: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    private let lightGradient = Gradient(colors: [
        Color.bbPersian.opacity(0.5),
        Color.bbForestGreen.opacity(0.5),
    ])
    
    private let darkGradient = Gradient(colors: [
        Color.bbPersian.opacity(0.4),
        Color.bbForestGreen.opacity(0.5),
    ])
    
    private var backgroundGradient: Gradient {
        colorScheme == .dark ? darkGradient : lightGradient
    }
    
    private var isZeroInputNumber: Bool {
        inputNumber == "0" || inputNumber.isEmpty
    }
    
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
                    
                    Text("\(selectedRadix.localizedName) base")
                        .font(.callout.smallCaps())
                        .foregroundStyle(.accent)
                    
                    Picker("Select a base", selection: $selectedRadix) {
                        ForEach(Radix.allCases, id: \.self) {
                            Text($0.numberName)
                        }
                    }
                    .pickerStyle(.palette)
                    .onChange(of: selectedRadix) { oldvalue, newValue in
                        handleRadixChange(
                            oldValue: oldvalue,
                            newValue: newValue
                        )
                    }
                    
                    HStack(spacing: 30) {
                        Spacer()
                        
                        Button("Clear", role: .destructive) {
                            clearTextField()
                        }
                        .frame(width: 100, height: 33)
                        .background(.bbEngineeringOrange)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        
                        Button("Convert") {
                            withAnimation {
                                fillRadixConversionSet()
                            }
                        }
                        .frame(width: 100, height: 33)
                        .background(.bbForestGreen)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding([.top, .horizontal])
                
                List {
                    if !radixConversions.isEmpty {
                        Section {
                            ForEach(radixConversions, id:\.radix) { radixConversion in
                                ListRow(
                                    currentRadix: radixConversion.radix,
                                    selectedRadix: selectedRadix,
                                    value: radixConversion.value
                                )
                                .listRowBackground(Color.clear)
                            }
                        } header: {
                            ListSectionHeader(
                                title: String(localized: "Conversions")
                            )
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .padding(.bottom)
                .overlay {
                    if radixConversions.isEmpty {
                        EmptyRadixConversions()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Basebook")
            .background(backgroundGradient)
            .alert(
                "Warning!",
                isPresented: $showingConversionAlert,
                actions: { Button("OK") { clearTextField() } },
                message: { Text(alertMessage) }
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        "History",
                        systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
                    ) {
                        // show history
                    }
                }
            }
        }
    }
    
    private func clearTextField() {
        withAnimation {
            inputNumber = ""
            radixConversions = []
        }
    }
    
    private func handleRadixChange(oldValue: Radix, newValue: Radix) {
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
    
    private func fillRadixConversionSet() {
        if isZeroInputNumber {
            alertMessage = ConversionError.zeroNumber.localizedDescription
            showingConversionAlert = true
            
            return
        }
        
        if !radixConversions.isEmpty {
            radixConversions.removeAll(keepingCapacity: true)
        }
        
        do {
            let decimalInputNumber = try RadixConverter.convert(
                inputNumber,
                from: selectedRadix.value
            )
            
            radixConversions = ConversionsViewModel.getConversionSet(
                for: decimalInputNumber
            )
            
            isTextFieldFocused = false
        } catch let error as ConversionError {
            alertMessage = error.localizedDescription
            showingConversionAlert = true
        } catch {
            alertMessage = ConversionError.unexpectedError.localizedDescription
            showingConversionAlert = true
            
            return
        }
    }
}

#Preview {
    ContentView()
}
