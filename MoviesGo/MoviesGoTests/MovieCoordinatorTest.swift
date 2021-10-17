// MovieCoordinatorTest.swift
// Copyright © Boris. All rights reserved.

@testable import MoviesGo
import UIKit
import XCTest

final class MovieCoordinatorTest: XCTestCase {
    var aplicationCoordinator: AplicationCoordinator!
    var navController: MockNavigationController!
    var assambly: AssamblyPrrotocol!

    override func setUpWithError() throws {
        navController = MockNavigationController()
        assambly = Assambly()
        aplicationCoordinator = AplicationCoordinator(assambly: assambly, navController: navController)
    }

    override func tearDownWithError() throws {
        navController = nil
        assambly = nil
        aplicationCoordinator = nil
    }

    func testMenuViewController() {
        aplicationCoordinator.start()
        let menuViewController = navController.presentedVC
        XCTAssertTrue(menuViewController is MenuViewController)
    }

    func testDetailsViewController() {
        aplicationCoordinator.start()
        guard let menuVC = navController.presentedVC as? MenuViewController else { return }
        menuVC.onSelectID?(Int())
        let detailsVC = navController.presentedVC
        XCTAssertTrue(detailsVC is DetailsViewController)
    }
}
