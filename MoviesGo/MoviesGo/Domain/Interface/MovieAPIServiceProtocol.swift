// MovieAPIServiceProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func fetchDataMovie(completion: @escaping (Swift.Result<[Movie], ResponsSessionError>) -> Void)
    func fetchDataDetails(
        movieID: Int,
        completion: @escaping (Swift.Result<DetailsMovie, ResponsSessionError>) -> Void
    )
}
