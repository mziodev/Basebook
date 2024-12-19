//
//  WhatsNewView.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct WhatsNewView: View {
    @Environment(\.dismiss) private var dismiss
    
    private func dismissView() { dismiss() }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Version 1.0.1") {
                    UpdateView(
                        text: String(
                            localized: "We’ve made some improvements to the history list. Now, the conversions are grouped by year, making it easier to find what you’re looking for."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "Now if the history list is empty a 'No conversions yet.' message will appear, and the Delete History button will be disabled."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "In this new version, if the input field is empty, the Convert button will be disabled."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "We've made lots of internal code improvements so the app runs faster and smoother."
                        )
                    )
                }
                
                Section("Version 1.0") {
                    UpdateView(
                        text: String(
                            localized: "Gorgeous and easy to use UI with light and dark mode support."
                        )
                    )
                    
                    UpdateView(
                        text: String(
                            localized: "Support for the most used bases: Binary, Trinary, Quaternary, Quinary, Senary, Octal, Nonary, Decimal, Duodecimal, and Hexadecimal."
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
            .forestGreenGradientBackground()
            .navigationTitle("What's New")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
}

#Preview {
    WhatsNewView()
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
