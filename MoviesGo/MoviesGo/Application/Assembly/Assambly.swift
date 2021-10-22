// Assambly.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class Assambly: AssamblyProtocol {
    func createMenuViewModel() -> UIViewController {
        let menuVC = MenuViewController()
        let movieAPIService = MovieAPIService()
        let repository = MenuRepository()
        let menuViewModel = MenuViewModel(movieAPIService: movieAPIService, repository: repository)
        menuVC.injectionViewModel(viewModel: menuViewModel)
        return menuVC
    }

    func createDetailsViewModel(movieID: Int) -> UIViewController {
        let detailsVC = DetailsViewController()
        let movieAPIService = MovieAPIService()
        let repositoty = DetailsRepository()
        let detailsViewModel = DetailsViewModel(
            movieAPIService: movieAPIService,
            movieID: movieID,
            repository: repositoty
        )
        detailsVC.injectionViewModel(viewModel: detailsViewModel)
        return detailsVC
    }
}
