//
//  SampleData.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import Foundation
import SwiftData

/// A singleton class that manages sample data for the application.
///
/// The `SampleData` class is responsible for creating and managing a model
/// container that holds sample data for the application. It initializes the
/// data model and provides access to the main context for data operations.
@MainActor
class SampleData {

    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    /// A sample `RadixConversionSet` instance from the sample data.
    var radixConversionSet: RadixConversionSet {
        RadixConversionSet.sampleData[0]
    }
    
    /// Private initializer to set up the model container and insert sample data.
    private init() {
        let schema = Schema([
            RadixConversionSet.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            
            insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    /// Inserts sample data into the model context.
    private func insertSampleData() {
        
        RadixConversionSet.sampleData.forEach {
            modelContext.insert($0)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Sample data modelContext failed to save.")
        }
    }
}
