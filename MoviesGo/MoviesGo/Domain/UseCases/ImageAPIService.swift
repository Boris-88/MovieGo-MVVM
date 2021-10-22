// ImageAPIService.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public Methods

    func getPhoto(url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
}
