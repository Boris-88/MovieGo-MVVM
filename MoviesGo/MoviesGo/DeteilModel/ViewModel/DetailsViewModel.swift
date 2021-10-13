// DetailsViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol {
    var details: DetailsMovie? { get set }
    var updateData: VoidHendler? { get set }
    var showError: ((String, Bool, @escaping VoidHendler) -> ())? { get set }
    func loadData()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Internal properties

    var showError: ((String, Bool, @escaping VoidHendler) -> ())?
    var details: DetailsMovie?
    var updateData: VoidHendler?
    var movieID: Int

    // MARK: - Private propertie

    private var movieAPIService: MovieAPIServiceProtocol!

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
    }

    private var stateView: ViewState<DetailsMovie> = .loading {
        didSet {
            switch stateView {
            case let .data(model):
                details = model
                updateData?()
            case .loading:
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

    // MARK: - Internal function

    func loadData() {
        movieAPIService.fetchDataDetails(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                switch error {
                case let .failure(error):
                    self.stateView = .error(.failure(error))
                case .failureDecode:
                    self.stateView = .error(.failureDecode)
                case .notData:
                    self.stateView = .error(.notData)
                }
            case let .success(data):
                self.stateView = .data(data)
            }
        }
    }
}
