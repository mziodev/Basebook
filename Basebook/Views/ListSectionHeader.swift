//
//  ListSectionHeader.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import SwiftUI

struct ListSectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.callout.smallCaps())
    }
}

#Preview {
    List {
        Section {
            // section content
        } header: {
            ListSectionHeader(title: "Conversions")
        }
    }
}
