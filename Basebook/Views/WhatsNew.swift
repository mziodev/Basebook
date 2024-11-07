//
//  WhatsNew.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct WhatsNew: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Version 1.0") {
                    UpdateView(
                        text: String(
                            localized: "Gorgeous and easy to use UI with light and dark mode support."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "Support for the most used bases: Binary, Trinary, Quaternary, Quinary, Senary, Octal, Nonary, Hexadecimal, Duodecimal, and Hexadecimal."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "Every conversion operation is saved in a history store, so you can always go back and check them out!."
                        )
                    )
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .secondaryGradientBackground()
            .navigationTitle("What's New")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

#Preview {
    WhatsNew()
}

struct UpdateView: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top ,spacing: 5) {
            Image(systemName: "checkmark.square.fill")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            Text(text)
        }
        .listRowBackground(Color.clear)
    }
}
