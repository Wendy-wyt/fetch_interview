//
//  DataImporter.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/27/24.
//

import Foundation
import SwiftData

struct DataImporter {
    
    @MainActor
    func importData(container: ModelContainer, dataLoader: DataLoader) async throws {
        
        let context = container.mainContext
            
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
    }
}
