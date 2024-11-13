//
//  ListSectionHeader.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import SwiftUI

struct HistoryListSectionHeader: View {
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
            HistoryListSectionHeader(title: "Conversions")
        }
    }
}
