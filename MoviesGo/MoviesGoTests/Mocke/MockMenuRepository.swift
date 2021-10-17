// MockMenuRepository.swift
// Copyright © Boris. All rights reserved.

@testable import MoviesGo
import UIKit
import XCTest

/// MockMenuRepository
class MockMenuRepository: RepositoryMenuProtocol {
    func getObjectMovie(object: [Movie]?) -> [Movie]? {
        []
    }

    func saveObjectMovie(object: [Movie]) {}
    func deleteObjectMovie(object: [Movie]) {}
}
