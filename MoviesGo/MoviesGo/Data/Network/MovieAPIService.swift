// MovieAPIService.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

final class MovieAPIService: MovieAPIServiceProtocol {
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetchDataMovie(completion: @escaping (Swift.Result<[Movie], ResponsSessionError>) -> Void) {
        let urlString = HTTPSettigs.baseURL + "\(HTTPMethod.popular)" + "?" + "api_key=\(HTTPSettigs.apiKey)" + "&" +
            "language=\(HTTPSettigs.language)"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let resData = try self.decoder.decode(PageDataMovie.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(resData.results))
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
