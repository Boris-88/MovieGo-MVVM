// AssamblyProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

protocol AssamblyProtocol {
    func createMenuViewModel() -> UIViewController
    func createDetailsViewModel(movieID: Int) -> UIViewController
}
