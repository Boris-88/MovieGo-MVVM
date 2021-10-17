// MenuViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation
import RealmSwift

protocol MenuViewModelProtocol: AnyObject {
    var movies: [Movie]? { get set }
    var updateData: VoidHendler? { get set }
    var showError: ((String, Bool, @escaping VoidHendler) -> ())? { get set }
    func loadData()
}

final class MenuViewModel: MenuViewModelProtocol {
    // MARK: - Internal properties

    var movies: [Movie]?
    var updateData: VoidHendler?
    var showError: ((String, Bool, @escaping VoidHendler) -> ())?

    // MARK: - Private propertie

    private var dataState: DataState<[Movie]> = .reLoading {
        didSet {
            switch dataState {
            case let .data(model):
                movies = model
                updateData?()
            case .reLoading:
                break
            case let .error(errorType):
                movies = nil
                updateData?()

                let errorDescription: String
                let isReload: Bool

                switch errorType {
                case let .failure(text):
                    errorDescription = text.localizedDescription
                    isReload = true
                case .failureDecode:
                    errorDescription = "Ошибка декодирования"
                    isReload = false
                case .notData:
                    errorDescription = "Отсуствуют данные"
                    isReload = false
                }
                showError?(errorDescription, isReload) { [weak self] in
                    self?.loadData()
                }
            }
        }
    }

    private var movieAPIService: MovieAPIServiceProtocol!
    private var repository: RepositoryMenuProtocol

    init(movieAPIService: MovieAPIServiceProtocol, repository: RepositoryMenuProtocol) {
        self.movieAPIService = movieAPIService
        self.repository = repository
        loadData()
    }

    // MARK: - Internal function

    func loadData() {
        movies?.removeAll()
        let casheObject = repository.getObjectMovie(object: movies)

        if (casheObject?.isEmpty) != nil {
            movieAPIService.fetchDataMovie { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):

                    switch error {
                    case let .failure(error):
                        self.dataState = .error(.failure(error))
                    case .failureDecode:
                        self.dataState = .error(.failureDecode)
                    case .notData:
                        self.dataState = .error(.notData)
                    }

                case let .success(movies):
                    DispatchQueue.main.async {
                        self.repository.saveObjectMovie(object: movies)
                        self.dataState = Bool.random() ? .error(.failure(TestError())) : .data(movies)
                    }
                }
            }
        } else {
            movies = casheObject
            DispatchQueue.main.async {
                self.updateData?()
            }
        }
    }
}

// Test Error
struct TestError: Error {}
