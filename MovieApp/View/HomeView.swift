//
//  HomeView.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 18/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    FeaturedMoviesView()

                    MoviesListView(title: "Popular", sortBy: "popularity.desc")

                    MoviesListView(title: "New Releases", sortBy: "release_date.desc", orientation: "vertical")
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            })
            .background(Color("background"))
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
