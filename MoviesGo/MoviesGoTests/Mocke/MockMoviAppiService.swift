// MockMoviAppiService.swift
// Copyright © Boris Zverik. All rights reserved.

//
//  MockMoviAppiService.swift
//  MoviesGoTests
//
//  Created by Boris Zverik on 17.10.2021.
//
@testable import MoviesGo
import UIKit
import XCTest

/// MovieAPIServiceProtocol
class MockMoviAppiService: MovieAPIServiceProtocol {
    var movies: [Movie] = []

    func fetchDataMovie(completion: @escaping (Result<[Movie], ResponsSessionError>) -> Void) {
        let movie = Movie()
        movie.id = 0
        movie.title = "Baz"
        movie.overview = "Bar"
        movie.posterPath = "BazBar"
        movie.releaseDate = "15.10.2021"
        movie.voteAverage = 0
        movies.append(movie)
        completion(.success(movies))
    }

    func fetchDataDetails(movieID: Int, completion: @escaping (Result<DetailsMovie, ResponsSessionError>) -> Void) {
        let details = DetailsMovie()
        details.title = "Baz"
        details.overview = "Bar"
        details.posterPath = "BazBar"
        details.releaseDate = "15.10.2021"
        details.voteAverage = 0
        completion(.success(details))
    }
}
