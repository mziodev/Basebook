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
                        Link(
                            "mziodev@gmail.com",
                            destination: BasebookURL.email
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
                            destination: BasebookURL.privacyPolicy
                        )
                        
                        Link(
                            "Terms of Service (EULA)",
                            destination: BasebookURL.termsOfUse
                        )
                    }
                    
                    Section("About Basebook") {
                        AppInfo(
                            text: String(localized: "Version number:"),
                            number: appVersionNumber
                        )
                        
                        AppInfo(
                            text: String(localized: "Build number:"),
                            number: appBuildNumber
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
}

#Preview {
    Support()
}
