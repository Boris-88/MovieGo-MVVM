// MovieAPIService.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func fetchDataMovie(completion: @escaping (Swift.Result<PageDataMovie, ResponsSessionError>) -> Void)
    func fetchDataDetails(
        movieID: Int,
        completion: @escaping (Swift.Result<DetailsMovie, ResponsSessionError>) -> Void
    )
}

final class MovieAPIService: MovieAPIServiceProtocol {
    func fetchDataMovie(completion: @escaping (Swift.Result<PageDataMovie, ResponsSessionError>) -> Void) {
        let urlString = HTTPSettigs.baseURL + "\(HTTPMethod.popular)" + "?" + "api_key=\(HTTPSettigs.apiKey)" + "&" +
            "language=\(HTTPSettigs.language)"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let resData = try JSONDecoder().decode(PageDataMovie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(resData))
                }
            } catch let error as ResponsSessionError {
                completion(.failure(error))
            } catch {
                completion(.failure(.notData))
            } catch {
                completion(.failure(.failureDecode))
                print("Ошибка декодирования")
            }
        }.resume()
    }

    func fetchDataDetails(
        movieID: Int,
        completion: @escaping (Swift.Result<DetailsMovie, ResponsSessionError>) -> Void
    ) {
        let urlString = HTTPSettigs.baseURL + "\("movie/\(movieID)")" + "?" +
            "api_key=\(HTTPSettigs.apiKey)" + "&" +
            "language=\(HTTPSettigs.language)"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let resData = try JSONDecoder().decode(DetailsMovie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(resData))
                    print(resData)
                }
            } catch let error as ResponsSessionError {
                completion(.failure(error))
            } catch {
                completion(.failure(.notData))
            } catch {
                completion(.failure(.failureDecode))
                print("Ошибка декодирования")
            }
        }.resume()
    }
}
