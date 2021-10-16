// ImageAPIService.swift
// Copyright © Boris. All rights reserved.

import UIKit

// protocol ImageAPIServiceProtocol {
//
//    func getImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ())
// }
//
// final class ImageAPIService: ImageAPIServiceProtocol {
//
//    func getImage(posterPath: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> ()) {
//
//        DispatchQueue.global().async {
//            guard let posterPath = posterPath,
//                  let url = URL(string: HTTPSettigs.imageHost + posterPath),
//                  let imageData = try? Data(contentsOf: url),
//                  let conteiner = UIImage(data: imageData)
//            else {
//                let error = NSError()
//                complition(.failure(error))
//                return
//            }
//            DispatchQueue.main.async {
//                complition(.success(conteiner))
//            }
//        }
//    }
// }

protocol ImageAPIServiceProtocol {
    func getPhoto(url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

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
