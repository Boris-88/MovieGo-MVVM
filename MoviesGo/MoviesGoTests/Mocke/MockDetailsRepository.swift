// MockDetailsRepository.swift
// Copyright © Boris. All rights reserved.

@testable import MoviesGo
import UIKit
import XCTest

/// MockDetailsRepository
class MockDetailsRepository: RepositoryDetailsProtocol {
    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]? {
        []
    }

    func saveObjectDetailsMovie(object: [DetailsMovie]) {}
    func deleteObjectDetailsMovie(object: [DetailsMovie]) {}
}
