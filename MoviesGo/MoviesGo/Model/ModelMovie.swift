// ModelMovie.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

/// Model PageDataMovie
struct PageDataMovie {
    let page: Int
    let movies: [Movie]
    let totalPage: Int
    let totalResults: Int
}

extension PageDataMovie: Decodable {
    private enum MovieCodingKeys: String, CodingKey {
        case currentPage = "page"
        case movies = "results"
        case totalPage = "total_pages"
        case totalResults = "total_results"
        case posterKeyPath = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        page = try container.decode(Int.self, forKey: .currentPage)
        totalPage = try container.decode(Int.self, forKey: .totalPage)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}

/// Model Movie
struct Movie {
    let posterPath: String?
    let id: Int
    let overview: String
    let title: String
    let releaseDate: String
    let popularity: Double
    let voteAverage: Double
}

extension Movie: Decodable {
    private enum MovieCodingKeys: String, CodingKey {
        case posterKeyPath = "poster_path"
        case movieID = "id"
        case overViewMovie = "overview"
        case titleMovie = "title"
        case releaseDate = "release_date"
        case popularyMovie = "popularity"
        case voteAverageMovie = "vote_average"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try container.decode(Int.self, forKey: .movieID)
        posterPath = try container.decode(String?.self, forKey: .posterKeyPath)
        title = try container.decode(String.self, forKey: .titleMovie)
        overview = try container.decode(String.self, forKey: .overViewMovie)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        popularity = try container.decode(Double.self, forKey: .popularyMovie)
        voteAverage = try container.decode(Double.self, forKey: .voteAverageMovie)
    }
}
