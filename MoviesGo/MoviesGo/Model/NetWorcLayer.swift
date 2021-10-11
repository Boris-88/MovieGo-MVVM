// NetWorcLayer.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

final class NetWorcLayer {
    func fetchData<T: Decodable>(
        _ type: T.Type,
        mainHost: String = AppSetting.dataHost,
        methodStr: String = "movie/top_rated",
        completion: @escaping (Result<T, ResponsSessionError>) -> Void
    ) {
        let urlString = mainHost + "\(methodStr)" + "?" + "api_key=\(AppSetting.apiKey)" + "&" +
            "language=\(AppSetting.language)"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }

            if let error = error {
                completion(.failure(.failure(error)))
            } else if let data = data {
                if let resultData = self.parsetPageData(type, data: data) {
                    DispatchQueue.main.async {
                        completion(.success(resultData))
                    }
                } else {
                    completion(.failure(.failureDecode))
                }
            } else {
                completion(.failure(.notData))
            }
        }.resume()
    }

    private func parsetPageData<T: Decodable>(_ type: T.Type, data: Data) -> T? {
        try? JSONDecoder().decode(type, from: data)
    }
}
