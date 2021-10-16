// ModelMovie.swift
// Copyright © Boris. All rights reserved.

import Foundation
import RealmSwift

// Модель результата массива json
struct PageDataMovie: Decodable {
    var results: [Movie]
}

// Модель описание фильма первого экрана
class Movie: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var id = Int()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var popularity = Double()
    @objc dynamic var voteAverage = Double()
}
