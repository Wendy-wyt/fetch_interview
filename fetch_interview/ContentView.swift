//
//  ContentView.swift
//  fetch_interview
//
//  Created by Michael Zhang on 6/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var category: [CategoryMeal]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(category) { categoryMeal in
                    NavigationLink {
                        Text("Item at \(categoryMeal.strMeal)")
                    } label: {
                        Text(categoryMeal.strMeal)
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
}
