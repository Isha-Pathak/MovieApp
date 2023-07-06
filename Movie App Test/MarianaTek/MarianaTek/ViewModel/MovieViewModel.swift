//
//  MovieViewModel.swift
//  MarianaTek
//
//

import Foundation

class MovieViewModel {
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    func searchMovies(withQuery query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieService.searchMovies(withQuery: query, completion: completion)
    }
}
