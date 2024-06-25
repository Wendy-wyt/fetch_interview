//
//  apis.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import Foundation


let mealUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")

struct Category: Decodable {
    let meals: [MealShort]
}

struct MealShort: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct DataLoader {
    func fetchByCategory(category: String) async throws -> [MealShort] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=" + category) else {
            return []
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 
                httpResponse.statusCode == 200
        else { return [] }
        
        let category = try JSONDecoder().decode(Category.self, from: data)
        
        return category.meals
    }
}

