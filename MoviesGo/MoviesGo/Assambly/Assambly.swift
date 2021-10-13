// Assambly.swift
// Copyright © Boris. All rights reserved.

import Foundation
import UIKit

protocol AssamblyPrrotocol {}

final class Assambly: AssamblyPrrotocol {
    func createMenuViewModel() {
        let movieAPIService = MovieAPIService()
        let menuViewModel = MenuViewModel(movieAPIService: movieAPIService)
    }

    func createDetailsViewModel(movieID: Int) {
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: movieID)
    }
}
