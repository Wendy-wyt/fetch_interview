import Foundation
import SwiftData

@Model
final class Category {
    var name: String?
    var meals: [CategoryMeal] = []
    
    init(meals: [CategoryMeal]) {
        self.meals = meals
    }
}

@Model
final class CategoryMeal {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}

@Model
final class Meal {
    var strMeal: String = ""
    var idMeal: String = ""
    var strInstructions: String = ""
    var ingredients: [Ingredient]
    
    init(strMeal: String, idMeal: String, strInstructions: String, ingredients: [Ingredient]) {
        self.idMeal = idMeal
        self.ingredients = ingredients
        self.strMeal = strMeal
        self.strInstructions = strInstructions
    }
}

@Model
final class Ingredient {
    var strIngredient: String
    var strMeasure: String
    
    init(strIngredient: String, strMeasure: String) {
        self.strIngredient = strIngredient
        self.strMeasure = strMeasure
    }
}
