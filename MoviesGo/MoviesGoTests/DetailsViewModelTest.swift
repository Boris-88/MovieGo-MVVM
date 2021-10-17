// DetailsViewModelTest.swift
// Copyright © Boris. All rights reserved.

@testable import MoviesGo
import UIKit
import XCTest

final class DetailsViewModelTest: XCTestCase {
    var viewModel: DetailsViewModelProtocol!
    var movieAPIService: MovieAPIServiceProtocol!
    var repository: MockDetailsRepository!

    override func setUpWithError() throws {
        repository = MockDetailsRepository()
        movieAPIService = MockMoviAppiService()
        viewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: 1, repository: repository)
    }

    override func tearDownWithError() throws {}

    func testMovieViewModel() throws {
        viewModel.updateData = {}

        guard let details = viewModel.details else { return }
        XCTAssertTrue(!details.isEmpty)
    }
}
