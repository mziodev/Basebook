//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var inputNumber: String = ""
    @State private var selectedRadix: Radix = .decimal
    @State private var conversions: [(Radix, String)] = []
    @State private var showingConversionAlert: Bool = false
    
    @State private var alertMessage: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var isZeroInputNumber: Bool {
        inputNumber == "0" || inputNumber.isEmpty
    }
    
    private var backgroundGradient: Gradient {
        if colorScheme == .dark {
            Gradient(
                colors: [
                    Color.bbPersian.opacity(0.4),
                    Color.bbForestGreen.opacity(0.5),
                ]
            )
        } else {
            Gradient(
                colors: [
                    Color.bbPersian.opacity(0.5),
                    Color.bbForestGreen.opacity(0.5),
                ]
            )
        }
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
                    
                    Text("\(selectedRadix.name) base")
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
                                fillConversions()
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
                            ListSectionHeader(title: "Conversions")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .padding(.bottom)
                .overlay {
                    if conversions.isEmpty {
                        EmptyConversions()
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
            conversions = []
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
    
    private func fillConversions() {
        if isZeroInputNumber {
            alertMessage = ConversionError.zeroNumber.localizedDescription
            showingConversionAlert = true
            
            return
        }
        
        if !conversions.isEmpty {
            conversions.removeAll(keepingCapacity: true)
        }
        
        do {
            let decimalInputNumber = try RadixConverter.convert(
                inputNumber,
                from: selectedRadix.value
            )
            
            conversions = ConversionsViewModel.getConversions(
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
