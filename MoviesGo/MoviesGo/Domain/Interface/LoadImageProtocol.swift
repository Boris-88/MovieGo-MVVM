// LoadImageProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

protocol LoadImageProtocol {
    func loadImage(url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}
