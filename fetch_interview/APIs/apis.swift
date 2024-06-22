//
//  apis.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import Foundation


let mealUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")

func fetchDessert(categoryName: String, completionHandler: @escaping ([CategoryMeal]) -> Void) {
    let categoryUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") ??; default value
    var category: [CategoryMeal]
    
    let task = URLSession.shared.dataTask(with: categoryUrl, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error accessing swapi.co: /(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
              }

        if let data = data,
           let category = try? JSONDecoder().decode(Category.self, from: data) {
            category.name = categoryName
            completionHandler(category.meals ?? [])
        }
    })
    
    task.resume()
    
    completionHandler(category)
}
