// DetailsViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol {
    var details: [DetailsMovie]? { get set }
    var updateData: VoidHendler? { get set }
    var showError: ((String, Bool, @escaping VoidHendler) -> ())? { get set }
    func loadData()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Internal properties

    var showError: ((String, Bool, @escaping VoidHendler) -> ())?
    var details: [DetailsMovie]?
    var updateData: VoidHendler?
    var movieID: Int

    // MARK: - Private propertie

    private var movieAPIService: MovieAPIServiceProtocol!
    private var repository: RepositoryDetailsProtocol!

    private var dataState: DataState<DetailsMovie> = .reLoading {
        didSet {
            switch dataState {
            case let .data(model):
                details = [model]
                updateData?()
            case .reLoading:
                break
            case let .error(errorType):
                details = nil
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

    // MARK: - init

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int, repository: RepositoryDetailsProtocol) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        self.repository = repository
        loadData()
    }

    // MARK: - Internal function

    func loadData() {
        details?.removeAll()

        let casheObject = repository.getObjectDetailsMovie(object: details)

        if (casheObject?.isEmpty) != nil {
            movieAPIService.fetchDataDetails(movieID: movieID) { [weak self] result in
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

                case let .success(details):
                    DispatchQueue.main.async {
                        self.repository.saveObjectDetailsMovie(object: [details])
                        self.dataState = Bool.random() ? .error(.failure(TestError())) : .data(details)
                    }
                }
            }
        } else {
            details = casheObject
            DispatchQueue.main.async {
                self.updateData?()
            }
        }
    }
}
