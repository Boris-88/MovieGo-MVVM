// AplicationCoordinator.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class AplicationCoordinator: BaseCoordinator {
    // MARK: - Public properties

    var assambly: AssamblyPrrotocol
    var navController: UINavigationController?

    required init(assambly: AssamblyPrrotocol, navController: UINavigationController? = nil) {
        self.navController = navController
        self.assambly = assambly
        super.init(assambly: assambly, navController: navController)
    }

    // MARK: - ApplicationCoordinator

    override func start() {
        toMenu()
    }

    // MARK: - Private methods

    private func toMenu() {
        let coordinator = MainCoordinator(assambly: assambly, navController: navController)
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
