import Foundation
import SwiftData

@Model
class MealShortModel {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}

//@Model
//final class MealFull:Meal {
//    var strInstructions: String?
//    var ingredients: [Ingredient]?
//    
//    override init() {
//        super.init()
//    }
//}
//
//@Model
//final class Ingredient {
//    var strIngredient: String
//    var strMeasure: String
//    
//    init(strIngredient: String, strMeasure: String) {
//        self.strIngredient = strIngredient
//        self.strMeasure = strMeasure
//    }
//}
