// CacheImageServiceProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

protocol CacheImageServiceProtocol {
    func saveImageToCache(url: String, image: UIImage)
    func getImageFromCache(url: String) -> UIImage?
}
