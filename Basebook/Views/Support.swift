//
//  Support.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct Support: View {
    @Environment(\.dismiss) private var dismiss
    
    let appVersionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Link("mziodev@gmail.com", destination: URLs.email)
                    } header: {
                        Text("Contact Us")
                    } footer: {
                        HStack {
                            Spacer()
                            
                            Text("Report a problem or just send us some feedback.")
                        }
                    }
                    
                    Section("Policies") {
                        Link("Privacy Policy", destination: URLs.privacyPolicy)
                        
                        Link("Terms of Service (EULA)", destination: URLs.termsOfUse)
                    }
                    
                    Section("About Basebook") {
                        AboutApp(
                            text: String(localized: "Version number:"),
                            number: appVersionNumber
                        )
                        
                        AboutApp(
                            text: String(localized: "Build number:"),
                            number: appBuildNumber
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .overlay(alignment: .bottom) {
                    Copyright()
                }
            }
            .secondaryGradientBackground()
            .navigationTitle("Support")
            .toolbar {
                ToolbarItem {
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
    Support()
}

struct AboutApp: View {
    let text: String
    let number: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(text)
            
            Text(number)
                .fontDesign(.rounded)
                .bold()
                .foregroundStyle(.bbForestGreen)
        }
    }
}

struct Copyright: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("©2024 Mauricio Del Solar (MZiO)")
                .font(.caption)
                .foregroundStyle(Color.accent)
            
            Spacer()
        }
    }
}
