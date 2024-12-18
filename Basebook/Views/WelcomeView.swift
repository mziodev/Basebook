//
//  WelcomeView.swift
//  Basebook
//
//  Created by MZiO on 6/11/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Welcome to Basebook")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Feature(
                        symbolName: "function",
                        symbolColor: .bbEngineeringOrange,
                        title: String(localized: "Take control of you conversions"),
                        text: String(localized: "Select a base, enter a number and convert it to any other base. It's just that simple!")
                    )
                    
                    Feature(
                        symbolName: "numbers",
                        symbolColor: .bbForestGreen,
                        title: String(localized: "Includes the 10 most used bases"),
                        text: String(localized: "Bases included: Binary, Trinary, Quaternary, Quinary, Senary, Octal, Nonary, Decimal, Duodecimal and Hexadecimal.")
                    )
                    
                    Feature(
                        symbolName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                        symbolColor: .purple,
                        title: String(localized: "Save all your conversions"),
                        text: String(localized: "Basebook save every operation on Conversion History so you can come back to them later.")
                    )
                }
            }
            
            Button("Continue", action: goToApp)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .foregroundStyle(.white)
                .background(
                    .accent,
                    in: .rect(cornerRadius: 16)
                )
                .padding(.horizontal)
                .padding(.bottom)
        }
        .padding()
        .basebookGradientBackground()
    }
    
    func goToApp() { isFirstLaunch = false }
}

struct Feature: View {
    let symbolName: String
    let symbolColor: Color
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .frame(width: 70)
                .font(.system(size: 40))
                .foregroundStyle(symbolColor)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                
                Text(text)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
            }
        }
    }
}

#Preview {
    WelcomeView(isFirstLaunch: .constant(true))
}
