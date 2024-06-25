//
//  ContentView.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Query private var meals: [MealShortModel]
    
    var body: some View {
        List {
            Text("Desert").bold()
            ForEach(meals) { meal in
                Text(meal.strMeal)
            }
        }
    }
}

#Preview {
    ContentView()
}
