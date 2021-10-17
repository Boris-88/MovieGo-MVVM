// MockNavigationController.swift
// Copyright © Boris. All rights reserved.

//
//  MockNavigationController.swift
//  MoviesGoTests
//
//  Created by Boris Zverik on 17.10.2021.
//
@testable import MoviesGo
import UIKit
import XCTest

// MockNavigationController
class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
