//
//  fetch_interviewApp.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import SwiftUI
import SwiftData

@main
struct fetch_interviewApp: App {
    
    let container = try! ModelContainer(for: MealShortModel.self)
    let dataLoader = DataLoader()
    
    @MainActor
    private func importData() async {
        
        let context = container.mainContext
        
        do {
            
            // predicate to fetch MealShortModel objects
            var mealsDescriptor = FetchDescriptor<MealShortModel>()
            mealsDescriptor.fetchLimit = 1
            
            let persistedMeals = try context.fetch(mealsDescriptor)
            
            if persistedMeals.isEmpty {
                // fetch data
                let meals = try await dataLoader.fetchByCategory(category: "Dessert")
                // store data to on-device database
                if !meals.isEmpty {
                    meals.forEach{ meal in
                        let mealShortModel = MealShortModel(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal)
                        context.insert(mealShortModel)
                    }
                }
            }
        } catch {
            print(error)
        }
        
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await importData()
            }

        }.modelContainer(container)
    }
}
