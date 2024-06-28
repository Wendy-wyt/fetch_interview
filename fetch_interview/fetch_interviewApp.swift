//
//  fetch_interviewApp.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/22/24.
//

import SwiftUI
import SwiftData

@main
struct fetch_interviewApp: App {
    
    let container = try! ModelContainer(for: MealShortModel.self)
    let dataLoader = DataLoader()
    
    @State var initLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            VStack{
                if !initLoading {
                                ContentView()
                            } else {
                                LoadingView()
                            }
            }
            .task {
                        do {
                            let dataImporter = DataImporter()
                            try await dataImporter.importData(container: container, dataLoader: dataLoader)
                        } catch {
                            print(error)
                        }
                        self.initLoading = false
                    }
        }
        .modelContainer(container)
    }
}
