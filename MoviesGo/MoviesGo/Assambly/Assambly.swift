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
        let menuViewModel = MenuViewModel(movieAPIService: movieAPIService)
        menuVC.injectionViewModel(viewModel: menuViewModel)
        return menuVC
    }

    func createDetailsViewModel(movieID: Int) -> UIViewController {
        let detailsVC = DetailsViewController()
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: movieID)
        detailsVC.injectionViewModel(viewModel: detailsViewModel)
        return detailsVC
    }
}
