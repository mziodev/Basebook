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
    
    @State var radixConversionSet = RadixConversionSet()
    
    @State private var showingHistory: Bool = false
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
        radixConversionSet.inputNumber == "0" || radixConversionSet.inputNumber.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .trailing) {
                    TextField("0", text: $radixConversionSet.inputNumber)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 60))
                        .fontDesign(.rounded)
                        .focused($isTextFieldFocused)
                        .keyboardType(radixConversionSet.selectedRadix.keyboardType)
                        .textInputAutocapitalization(.never)
                    
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
                    if !radixConversionSet.radixConversions.isEmpty {
                        Section {
                            ForEach(radixConversionSet.radixConversions, id:\.radix) { radixConversion in
                                ListRow(
                                    currentRadix: radixConversion.radix,
                                    selectedRadix: radixConversionSet.selectedRadix,
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
                    if radixConversionSet.radixConversions.isEmpty {
                        EmptyRadixConversions()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Basebook")
            .background(backgroundGradient)
            .sheet(isPresented: $showingHistory) {
                HistoryList(
                    radixConversionSet: $radixConversionSet
                )
                .presentationDetents([.medium, .large])
            }
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
                        showingHistory = true
                    }
                }
            }
        }
    }
    
    private func clearTextField() {
        withAnimation {
            radixConversionSet.inputNumber = ""
            radixConversionSet.radixConversions = []
        }
    }
    
    private func handleRadixChange(oldValue: Radix, newValue: Radix) {
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
        
        if !radixConversionSet.radixConversions.isEmpty {
            radixConversionSet.radixConversions.removeAll(keepingCapacity: true)
        }
        
        do {
            let decimalInputNumber = try RadixConverter.convert(
                radixConversionSet.inputNumber,
                from: radixConversionSet.selectedRadix.value
            )
            
            radixConversionSet.radixConversions = ConversionsViewModel.getConversionSet(
                for: decimalInputNumber
            )
            
            let newRadixConversionSet = RadixConversionSet(
                inputNumber: radixConversionSet.inputNumber,
                selectedRadix: radixConversionSet.selectedRadix,
                radixConversions: radixConversionSet.radixConversions
            )
            
            modelContext.insert(newRadixConversionSet)
            
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
        .modelContainer(SampleData.shared.modelContainer)
}
