// Assambly.swift
// Copyright © Boris. All rights reserved.

import Foundation
import UIKit

protocol AssamblyPrrotocol {
    func createMenuViewModel() -> UIViewController
    func createDetailsViewModel(movieID: Int) -> UIViewController
}

final class Assambly: AssamblyPrrotocol {
    func createMenuViewModel() -> UIViewController {
        let menuVC = MenuViewController()
        let movieAPIService = MovieAPIService()
        let repository = Repository()
        let menuViewModel = MenuViewModel(movieAPIService: movieAPIService, repository: repository)
        menuVC.injectionViewModel(viewModel: menuViewModel)
        return menuVC
    }

    func createDetailsViewModel(movieID: Int) -> UIViewController {
        let detailsVC = DetailsViewController()
        let movieAPIService = MovieAPIService()
        let repositoty = Repository()
        let detailsViewModel = DetailsViewModel(
            movieAPIService: movieAPIService,
            movieID: movieID,
            repository: repositoty
        )
        detailsVC.injectionViewModel(viewModel: detailsViewModel)
        return detailsVC
    }
}
