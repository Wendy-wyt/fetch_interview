//
//  apis.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/22/24.
//

import Foundation


let mealUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")

struct CategoryShort: Decodable {
    let meals: [MealShort]
}

struct MealShort: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct CategoryDetail: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    let strInstructions: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreateiveCommonsConfirmed: String?
    let dateModified: String?
    let ingredientsDict: [[String]]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        
        var ingredientsDict = [[String]]()
        
        // Decode fixed fields
        self.idMeal = try container.decode(String.self, forKey: DynamicKey(stringValue: "idMeal")!)
        self.strMeal = try container.decode(String.self, forKey: DynamicKey(stringValue: "strMeal")!)
        self.strDrinkAlternate = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strDrinkAlternate")!)
        self.strCategory = try container.decode(String.self, forKey: DynamicKey(stringValue: "strCategory")!)
        self.strArea = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strArea")!)
        self.strInstructions = try container.decode(String.self, forKey: DynamicKey(stringValue: "strInstructions")!)
        self.strMealThumb = try container.decode(String.self, forKey: DynamicKey(stringValue: "strMealThumb")!)
        self.strTags = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strTags")!)
        self.strYoutube = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strYoutube")!)
        self.strSource = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strSource")!)
        self.strImageSource = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strImageSource")!)
        self.strCreateiveCommonsConfirmed = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strCreateiveCommonsConfirmed")!)
        self.dateModified = try? container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "dateModified")!)
        
        
        // Iterate over all keys in the container
        for key in container.allKeys {
            if key.stringValue.starts(with: "strIngredient") {
                let indexString = key.stringValue.dropFirst("strIngredient".count)
                let measureKey = DynamicKey(stringValue: "strMeasure\(indexString)")
                let ingredient = try container.decode(String.self, forKey: key)
                let measure = try container.decode(String.self, forKey: measureKey!)
                
                    if !ingredient.isEmpty {
                        ingredientsDict.append([ingredient, measure])
                    }
                
            }
        }
        
        self.ingredientsDict = ingredientsDict
    }
}

struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
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
        
        let category = try JSONDecoder().decode(CategoryShort.self, from: data)
        
        return category.meals
    }
    
    func fetchByMealId(mealId: String) async throws -> MealDetail? {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + mealId) else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
        else { return nil }
        
        let category = try JSONDecoder().decode(CategoryDetail.self, from: data)
        
        return category.meals[0]
    }
}

