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
    
    @State var radixConversionSet = RadixConversionSet()
    
    @State private var showingHistory: Bool = false
    @State private var showingWhatsNew: Bool = false
    @State private var showingSupport: Bool = false
    @State private var showingConversionAlert: Bool = false
    
    @State private var alertMessage: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TextField("0", text: $radixConversionSet.inputNumber)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 60))
                        .fontDesign(.rounded)
                        .focused($isTextFieldFocused)
                        .keyboardType(radixConversionSet.selectedRadix.keyboardType)
                        .textInputAutocapitalization(.never)
                    
                    RadixSelector(
                        radixConversionSet: $radixConversionSet,
                        isTextFieldFocused: Binding(
                            get: { isTextFieldFocused },
                            set: { isTextFieldFocused = $0 }
                        )
                    )
                    
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
                                processRadixConversionSet()
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
                
                RadixConversionList(radixConversionSet: radixConversionSet)
            }
            .primaryGradientBackground()
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Basebook")
            .sheet(isPresented: $isFirstLaunch) {
                Welcome(isFirstLaunch: $isFirstLaunch)
            }
            .sheet(isPresented: $showingHistory) {
                HistoryList(
                    radixConversionSet: $radixConversionSet
                )
                .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingWhatsNew) {
                WhatsNew()
            }
            .sheet(isPresented: $showingSupport) {
                Support()
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
    
    private func processRadixConversionSet() {
        
        if let error = try? radixConversionSet
            .loadRadixConversions(from: radixConversionSet.inputNumber) {
            
            alertMessage = error.localizedDescription
            showingConversionAlert = true
            
            return
        }
        
        let newRadixConversionSet = RadixConversionSet(
            inputNumber: radixConversionSet.inputNumber,
            selectedRadix: radixConversionSet.selectedRadix,
            radixConversions: radixConversionSet.radixConversions
        )
        
        modelContext.insert(newRadixConversionSet)
        
        isTextFieldFocused = false
    }
    
    private func showWhatsNew() {
        showingWhatsNew = true
    }
    
    private func showSupport() {
        showingSupport = true
    }
    
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
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
