//
//  DetailView.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/27/24.
//

import SwiftUI

struct DetailView: View {
    let meal: MealShortModel
    @State var mealDetail: MealDetail?
    @State var loading = true
    let dataLoader: DataLoader = DataLoader()
    
    var body: some View {
        VStack{
            if !loading {
                if let mealDetail = mealDetail {
                    ScrollView{
                        Text(mealDetail.strMeal).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            Spacer()
                                            URLImage(urlString: mealDetail.strMealThumb, width: 200, height: 130)
                                            Spacer()
                                            Text(mealDetail.strInstructions)
                                            Spacer()
                                            ForEach(0..<mealDetail.ingredientsDict.count, id: \.self) {
                                                index in
                                                Text("\(mealDetail.ingredientsDict[index][0]) : \(mealDetail.ingredientsDict[index][1])")
                                            }
                    }
                    .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                } else {
                        Text("Unable to find details")
                }
            } else {
                LoadingView()
            }
        }.task{
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            if let mealDetail = try await dataLoader.fetchByMealId(mealId: meal.idMeal) {
                        self.mealDetail = mealDetail
                    }
        } catch {
            print(error)
        }
        self.loading = false
    }
}
