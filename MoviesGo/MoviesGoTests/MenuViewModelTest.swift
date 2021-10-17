// MenuViewModelTest.swift
// Copyright © Boris. All rights reserved.

@testable import MoviesGo
import UIKit
import XCTest

// MenuViewModelTest
final class MenuViewModelTest: XCTestCase {
    var viewModel: MenuViewModelProtocol?
    var movieAPIService: MovieAPIServiceProtocol!
    var repository: MockMenuRepository!

    override func setUpWithError() throws {
        repository = MockMenuRepository()
        movieAPIService = MockMoviAppiService()
        viewModel = MenuViewModel(movieAPIService: movieAPIService, repository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        movieAPIService = nil
        viewModel = nil
    }

    func testMovieViewModel() throws {
        viewModel?.updateData = {}

        guard let movies = viewModel?.movies else { return }
        XCTAssertTrue(!movies.isEmpty)
    }
}
