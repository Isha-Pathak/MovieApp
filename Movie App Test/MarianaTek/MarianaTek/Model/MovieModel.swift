//
//  MovieModel.swift
//  MarianaTek
//
//

import Foundation
struct SearchResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable,Equatable {
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
    }
}
