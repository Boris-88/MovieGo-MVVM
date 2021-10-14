// BaseCoordinator.swift
// Copyright © Boris. All rights reserved.

import UIKit

protocol BaseCoordinatorProtocol {
    var childCoordinators: [BaseCoordinator] { get set }
    func start()
    func addDependency(_ coordinator: BaseCoordinator)
    func removeDependency(_ coordinator: BaseCoordinator?)
    func setAsRoot(_ controller: UIViewController)
}

// Базовый координатор
class BaseCoordinator: BaseCoordinatorProtocol {
    // MARK: - Public Properties

    var childCoordinators: [BaseCoordinator] = []

    required init(assambly: AssamblyPrrotocol, navController: UINavigationController? = nil) {}

    // MARK: - Public functions

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
