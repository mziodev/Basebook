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
    
    private var historyGroupedByYear: [(String, [RadixConversionSet])] {
        Dictionary(grouping: history) { (radixConversionSet) -> String in
            let year = Calendar.current.component(
                .year,
                from: radixConversionSet.date
            )
            return String(year)
        }
        .sorted { $0.key > $1.key }
        .map { ($0.key, $0.value) }
    }
    
    private func dismissView() { dismiss() }
    
    private func deleteItem(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(history[$0]) }
    }
    
    private func confirmClearHistory() {
        showingClearHistoryAlert = true
    }
    
    private func clearHistory() {
        history.forEach { modelContext.delete($0) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(historyGroupedByYear, id: \.0) {
                    year,
                    conversionSets in
                    Section {
                        ForEach(
                            Array(zip(conversionSets.indices, conversionSets)),
                            id: \.1
                        ) { index, conversionSet in
                            HistoryListRow(radixConversionSet: conversionSet)
                                .listRowBackground(Color.clear)
                                .onTapGesture {
                                    radixConversionSet.copy(from: conversionSet)
                                    dismissView()
                                }
                        }
                        .onDelete { offsets in
                            for offset in offsets {
                                modelContext.delete(history[offset])
                            }
                        }
                    } header: {
                        Text(year)
                            .foregroundStyle(.accent)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .forestGreenGradientBackground()
            .navigationTitle("History")
            .overlay {
                if history.isEmpty {
                    Text("No history yet")
                        .foregroundStyle(.secondary)
                }
            }
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
                        .background(
                            history.isEmpty ? Color.gray : Color.bbEngineeringOrange
                        )
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 6))
                        .padding(.top)
                        .disabled(history.isEmpty)
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .bottomBar)
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

#Preview {
    HistoryList(radixConversionSet: .constant(SampleData.shared.radixConversionSet))
        .modelContainer(SampleData.shared.modelContainer)
}
