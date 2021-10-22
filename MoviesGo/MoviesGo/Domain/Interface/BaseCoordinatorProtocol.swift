// BaseCoordinatorProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

protocol BaseCoordinatorProtocol {
    var childCoordinators: [BaseCoordinator] { get set }
    func start()
    func addDependency(_ coordinator: BaseCoordinator)
    func removeDependency(_ coordinator: BaseCoordinator?)
    func setAsRoot(_ controller: UIViewController)
}
