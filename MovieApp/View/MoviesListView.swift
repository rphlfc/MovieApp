//
//  MoviesListView.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 23/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesListView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var title: String
    var sortBy: String
    
    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.items ?? viewModel.placeholders, id: \.id) { item in
                        NavigationLink(
                            destination: MovieDetailsView(item: item),
                            label: {
                                MovieItemView(item: item, orientation: orientation)
                            })
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.fetchData(sortBy: sortBy)
        }
    }
}

struct MovieItemView: View {
    var item: Movie
    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\((orientation == "horizontal" ? item.backdrop_path : item.poster_path) ?? "")"))
                .resizable()
                .scaledToFill()
                .frame(width: orientation == "horizontal" ? 200 : 160, height: orientation == "horizontal" ? 120 : 240)
                .redacted(reason: item.poster_path == nil ? .placeholder : .init())
                .cornerRadius(8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title ?? "Carregando...")
                        .font(.system(size: orientation == "horizontal" ? 17 : 15))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .redacted(reason: item.title == nil ? .placeholder : .init())
                    
                    Text(item.overview ?? "Carregando...")
                        .font(.system(size: orientation == "horizontal" ? 15 : 13))
                        .lineLimit(2)
                        .foregroundColor(.gray)
                        .redacted(reason: item.overview == nil ? .placeholder : .init())
                }
                
                Spacer()
            }
        }
        .frame(width: orientation == "horizontal" ? 200 : 160)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(title: "TITLE", sortBy: "popularity.asc")
    }
}
