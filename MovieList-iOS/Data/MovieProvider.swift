//
//  MovieProvider.swift
//  MovieList-iOS
//
//  Created by Mananas on 4/12/25.
//

import Foundation

class MovieProvider {
    
    static let BASE_URL = "https://www.omdbapi.com/?apikey=c5dc9efb"
    
    static func getMoviesByName(name: String) async -> MovieResponse {
        guard let url = URL(string: "\(BASE_URL)&s=\(name)") else {
            return MovieResponse(Search: [], Response: "False", Error: "Invalid URL")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MovieResponse.self, from: data)
        } catch {
            debugPrint(error)
            return MovieResponse(Search: [], Response: "False", Error: "Failed to decode data")
        }
    }
    
    static func getMovieDetails(imdbID: String) async -> MovieDetail? {
        guard let url = URL(string: "\(BASE_URL)&i=\(imdbID)") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MovieDetail.self, from: data)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
