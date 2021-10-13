// ServiceImageManager.swift
// Copyright © Boris. All rights reserved.

import UIKit

protocol ServiceImageManagerProtocol {
    func updateImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ServiceImageManager: ServiceImageManagerProtocol {
    func updateImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        DispatchQueue.global().async {
            DispatchQueue.global().async {
                guard let posterPath = posterPath,
                      let url = URL(string: HTTPSettigs.imageHost + posterPath),
                      let imageData = try? Data(contentsOf: url),
                      let conteiner = UIImage(data: imageData)
                else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    complition(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    complition(.success(conteiner))
                }
            }
        }
    }
}
