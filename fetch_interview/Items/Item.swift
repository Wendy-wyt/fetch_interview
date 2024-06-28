//
//  Item.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/22/24.
//


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
