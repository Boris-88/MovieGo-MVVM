// MoviesGoUITests.swift
// Copyright © Boris Zverik. All rights reserved.

import XCTest

final class MoviesGoUITests: XCTestCase {
    var aplication = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        aplication = XCUIApplication()
        aplication.launch()
    }

    func testExample() throws {
        aplication.launch()
        let collectionView = aplication.collectionViews["collectionView"]
        collectionView.swipeDown()
        let tapCell = aplication.cells.element(boundBy: 7)
        tapCell.tap()
        RunLoop.current.run(until: Date(timeInterval: 2, since: Date()))
        let labelOnSecondScreen = aplication.staticTexts["DescriptionModuleTitle"]
        XCTAssertTrue(!labelOnSecondScreen.label.isEmpty)
    }

    func testPosterImage() {
        let movieModuleTableView = aplication.tables["tableView"]
        movieModuleTableView.swipeDown()
        let tapEihtCell = movieModuleTableView.cells.element(boundBy: 7)
        tapEihtCell.tap()
        let imagePoster = XCUIApplication().images["PosterPatchTableViewCell"]
        XCTAssert(imagePoster.exists)
    }
}
