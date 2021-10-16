// DetailsModel.swift
// Copyright © Boris. All rights reserved.

import Foundation
import RealmSwift

// Модель описание фильма
class DetailsMovie: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var popularity = Double()
    @objc dynamic var voteAverage = Double()
}
