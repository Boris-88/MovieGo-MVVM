// MainCoordinator.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHendler?

    // MARK: - private Properties

    private var navController: UINavigationController?
    private var assambly: AssamblyProtocol

    required init(assambly: AssamblyProtocol, navController: UINavigationController? = nil) {
        self.assambly = assambly
        self.navController = navController
        super.init(assambly: assambly, navController: navController)
    }

    // MARK: - MainCoordinator

    override func start() {
        showMainModule()
    }

    // MARK: - Private methods

    private func showMainModule() {
        guard let menuVC = assambly.createMenuViewModel() as? MenuViewController else { return }
        menuVC.onSelectID = { [weak self] movieID in
            self?.showDetailsModule(movieID: movieID)
        }
        if navController == nil {
            let rootController = UINavigationController(rootViewController: menuVC)
            navController = rootController
            setAsRoot(rootController)
        } else if let navController = navController {
            navController.pushViewController(menuVC, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailsModule(movieID: Int) {
        let detailVC = assambly.createDetailsViewModel(movieID: movieID)
        navController?.pushViewController(detailVC, animated: true)
    }
}
