// ModelDetails.swift
// Copyright © Boris. All rights reserved.

import Foundation

/// Модель

/// Модель
struct DetailsMovie {
    let posterPath: String?
    let overview: String
    let title: String
    let releaseDate: String
    let popularity: Double
    let voteAverage: Double
}

extension DetailsMovie: Decodable {
    private enum MovieCodingKeys: String, CodingKey {
        case posterKeyPath = "poster_path"
        case overViewMovie = "overview"
        case titleMovie = "title"
        case releaseDate = "release_date"
        case popularyMovie = "popularity"
        case voteAverageMovie = "vote_average"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        posterPath = try container.decode(String?.self, forKey: .posterKeyPath)
        title = try container.decode(String.self, forKey: .titleMovie)
        overview = try container.decode(String.self, forKey: .overViewMovie)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        popularity = try container.decode(Double.self, forKey: .popularyMovie)
        voteAverage = try container.decode(Double.self, forKey: .voteAverageMovie)
    }
}
