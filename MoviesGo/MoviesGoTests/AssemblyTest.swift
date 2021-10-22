// AssemblyTest.swift
// Copyright © Boris Zverik. All rights reserved.

//
//  AssemblyTest.swift
//  MoviesGoTests
//
//  Created by Boris Zverik on 17.10.2021.
//
@testable import MoviesGo
import UIKit
import XCTest

final class AssemblyTest: XCTestCase {
    var assambly: AssamblyProtocol!

    override func setUpWithError() throws {
        assambly = Assambly()
    }

    override func tearDownWithError() throws {
        assambly = nil
    }

    func testAssemblySuccess() throws {
        let movieVC = assambly.createMenuViewModel()
        XCTAssertTrue(movieVC is MenuViewController)

        let detailsVC = assambly.createDetailsViewModel(movieID: 1)
        XCTAssertTrue(detailsVC is DetailsViewController)
    }

    func testAssemblyFailure() throws {
        let movieVC = assambly.createMenuViewModel()
        XCTAssertTrue(movieVC is MenuViewController)

        let detailsVC = assambly.createDetailsViewModel(movieID: 1)
        XCTAssertTrue(detailsVC is DetailsViewController)
    }
}
