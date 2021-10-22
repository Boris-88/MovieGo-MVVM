// ImageAPIServiceProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

protocol ImageAPIServiceProtocol {
    func getPhoto(url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}
