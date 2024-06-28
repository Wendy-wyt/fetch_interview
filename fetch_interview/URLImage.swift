//
//  URLImage.swift
//  fetch_interview
//
//  Created by Yuting Wu on 6/27/24.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat

    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .background(Color.gray)
        }else {
            Image(systemName: "video")
                .resizable(resizingMode: .tile)
                .frame(width:130, height:70)
                .background(Color.gray)
                .onAppear{fetchData()}
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            self.data = data
        }
        
        task.resume()
    }
}



#Preview {
    URLImage(urlString: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", width: 130, height: 70)
}
