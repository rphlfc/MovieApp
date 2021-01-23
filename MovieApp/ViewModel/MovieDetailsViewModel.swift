//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Raphael Cerqueira on 19/01/21.
//

import Foundation
import SwiftUI

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    
    func fetchData(id: Int) {
        
        let url = URL(string: "\(Constants.baseURl)/movie/\(id)?api_key=\(Constants.apiKey)&language=en-US")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                do {
                    let res: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data!)
                    print("Erro ao recuperar os filmes populares.", res.status_message!)
                    return
                } catch {
                    print(error)
                }
            }
            
            guard let data = data else { return }
            
            do {
                let result: Movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self.movie = result
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
