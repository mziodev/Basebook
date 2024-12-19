//
//  SupportView.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.dismiss) private var dismiss
    
    let appVersionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    private func dismissView() { dismiss() }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Link(
                            "mziodev@gmail.com",
                            destination: URLs.email
                        )
                    } header: {
                        Text("Contact Us")
                    } footer: {
                        HStack {
                            Spacer()
                            
                            Text("Report a problem or just send us some feedback.")
                        }
                    }
                    
                    Section("Policies") {
                        Link(
                            "Privacy Policy",
                            destination: URLs.privacyPolicy
                        )
                        
                        Link(
                            "Terms of Service (EULA)",
                            destination: URLs.termsOfUse
                        )
                    }
                    
                    Section("About Basebook") {
                        AppInfo(
                            text: String(localized: "Version number:"),
                            number: appVersionNumber
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .overlay {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("©2024 Mauricio Del Solar (MZiO)")
                                .font(.caption)
                                .foregroundStyle(.accent)
                            
                            Spacer()
                            
                        }
                    }
                }
            }
            .forestGreenGradientBackground()
            .navigationTitle("Support")
            .toolbar {
                ToolbarItem {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
}

#Preview {
    SupportView()
}

struct AppInfo: View {
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
