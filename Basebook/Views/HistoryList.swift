//
//  HistoryList.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import SwiftData
import SwiftUI

struct HistoryList: View {
    @Query(
        sort: \RadixConversionSet.date,
        order: .reverse
    ) private var history: [RadixConversionSet]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var radixConversionSet: RadixConversionSet
    
    @State private var showingClearHistoryAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(history) { radixConversionSet in
                    HistoryListRow(radixConversionSet: radixConversionSet)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            self.radixConversionSet = RadixConversionSet(
                                inputNumber: radixConversionSet.inputNumber,
                                selectedRadix: radixConversionSet.selectedRadix,
                                radixConversions: radixConversionSet.radixConversions
                            )
                            dismiss()
                        }
                }
                .onDelete(perform: deleteItem)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .background(
                Gradient(
                    colors: [
                        Color.bbForestGreen.opacity(0.2),
                        Color.bbForestGreen.opacity(0.6)
                    ]
                )
            )
            .navigationTitle("History")
            .alert(
                "Warning",
                isPresented: $showingClearHistoryAlert,
                actions: {
                    Button("Ok", role: .destructive) {
                        clearHistory()
                    }
                },
                message: {
                    Text("Are you sure you want to clear the history?")
                }
            )
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK", action: dismissView)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Clear History", action: confirmClearHistory)
                        .font(.headline)
                        .padding(.horizontal, 10)
                        .background(Color.bbEngineeringOrange)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 6))
                        .padding(.top)
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .bottomBar)
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private func deleteItem(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(history[$0]) }
    }
    
    private func confirmClearHistory() {
        showingClearHistoryAlert = true
    }
    
    private func clearHistory() {
        history.forEach { modelContext.delete($0) }
    }
}

#Preview {
    HistoryList(radixConversionSet: .constant(SampleData.shared.radixConversionSet))
        .modelContainer(SampleData.shared.modelContainer)
}
