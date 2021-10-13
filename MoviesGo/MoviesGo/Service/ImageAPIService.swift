// ImageAPIService.swift
// Copyright © Boris. All rights reserved.

import UIKit

protocol ImageAPIServiceProtocol {
    func updateImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    func updateImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        DispatchQueue.global().async {
            guard let posterPath = posterPath,
                  let url = URL(string: HTTPSettigs.imageHost + posterPath),
                  let imageData = try? Data(contentsOf: url),
                  let conteiner = UIImage(data: imageData)
            else {
                let error = NSError()
                complition(.failure(error))
                return
            }
            DispatchQueue.main.async {
                complition(.success(conteiner))
            }
        }
    }
}
