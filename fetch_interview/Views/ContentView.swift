//
//  ContentView.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Query private var meals: [MealShortModel]
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Text("Desert").bold()
                    ForEach(meals) { meal in
                        NavigationLink(destination: DetailView(meal: meal)) {
                            HStack {
                                URLImage(urlString: meal.strMealThumb, width: 130, height: 70)
                                Text(meal.strMeal)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
