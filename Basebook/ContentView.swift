//
//  ContentView.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage("FirstStart") private var isFirstLaunch: Bool = true
    
    @Environment(\.modelContext) var modelContext
    
    @Query private var radixConversionSets: [RadixConversionSet]
    
    @State private var radixConversionSet = RadixConversionSet()
    
    @State private var showingHistory: Bool = false
    @State private var showingWhatsNew: Bool = false
    @State private var showingSupport: Bool = false
    @State private var showingConversionAlert: Bool = false
    
    @State private var alertMessage: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var isInputNumberEmpty: Bool {
        radixConversionSet.inputNumber == "0" || radixConversionSet.inputNumber.isEmpty
    }
    
    private var isConverButtonDisabled: Bool {
        isInputNumberEmpty || radixConversionSets.containsSet(
            with: radixConversionSet.inputNumber,
            selectedRadix: radixConversionSet.selectedRadix.value
        )
    }

    private func showWhatsNew() { showingWhatsNew = true }
    
    private func showSupport() { showingSupport = true }
    
    private func showAppStoreRating() {
        let url = URLs.writeReview
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(
                url,
                options: [:],
                completionHandler: nil
            )
        }
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
                        .background(
                            radixConversionSet.inputNumber.isEmpty ? .gray : .bbForestGreen
                        )
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        .disabled(radixConversionSet.inputNumber.isEmpty)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding([.top, .horizontal])
                
                List {
                    if !radixConversionSet.radixConversions.isEmpty {
                        Section {
                            ForEach(radixConversionSet.radixConversions, id:\.radix) { radixConversion in
                                RadixConversionsListRow(
                                    currentRadix: radixConversion.radix,
                                    selectedRadix: radixConversionSet.selectedRadix,
                                    value: radixConversion.value
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
                    if radixConversionSet.radixConversions.isEmpty {
                        EmptyRadixConversionsView()
                    }
                }
            }
            .basebookGradientBackground()
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Basebook")
            .sheet(isPresented: $isFirstLaunch) {
                WelcomeView(isFirstLaunch: $isFirstLaunch)
            }
            .sheet(isPresented: $showingHistory) {
                HistoryList(
                    radixConversionSet: $radixConversionSet
                )
                .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingWhatsNew) {
                WhatsNewView()
            }
            .sheet(isPresented: $showingSupport) {
                SupportView()
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
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showWhatsNew) {
                        Label("What's New", systemImage: "sparkles")
                    }
                    
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showSupport) {
                        Label("Support", systemImage: "envelope.fill")
                    }
                    
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showAppStoreRating) {
                        Label("Rate this app", systemImage: "star.fill")
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
        if isInputNumberEmpty {
            alertMessage = ConversionError.zeroNumber.localizedDescription
            showingConversionAlert = true
            
            return
        } else {
            radixConversionSet.radixConversions.removeAll(keepingCapacity: true)
        }
        
        do {
            let decimalInputNumber = try RadixConversions.convert(
                radixConversionSet.inputNumber,
                from: radixConversionSet.selectedRadix.value
            )
            
            radixConversionSet.radixConversions = RadixConversions.calculate(
                for: decimalInputNumber
            )
            
            if !radixConversionSets.containsSet(
                    with: radixConversionSet.inputNumber,
                    selectedRadix: radixConversionSet.selectedRadix.value) {
                
                let newRadixConversionSet = RadixConversionSet(
                    inputNumber: radixConversionSet.inputNumber,
                    selectedRadix: radixConversionSet.selectedRadix,
                    radixConversions: radixConversionSet.radixConversions
                )
                
                modelContext.insert(newRadixConversionSet)
            } else {
                if let radixConversionSetToUpdate = radixConversionSets.getSet(
                    with: radixConversionSet.inputNumber,
                    selectedRadix: radixConversionSet.selectedRadix.value
                ) {
                    radixConversionSetToUpdate.date = .now
                    
                    modelContext.insert(radixConversionSetToUpdate)
                }
            }
            
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
