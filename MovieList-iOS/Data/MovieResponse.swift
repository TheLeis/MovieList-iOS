//
//  MovieResponse.swift
//  MovieList-iOS
//
//  Created by Mananas on 4/12/25.
//

import Foundation

struct MovieResponse: Codable {
    let Search: [Movie]?
    let Response: String
    let Error: String?
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
}

struct MovieDetail: Codable {
    let Title: String
    let Year: String
    let Poster: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Plot: String
    let Country: String
    let Response: String
    let Error: String?
}
