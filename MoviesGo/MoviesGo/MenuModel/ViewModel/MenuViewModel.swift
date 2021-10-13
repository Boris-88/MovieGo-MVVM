// MenuViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol MenuViewModelProtocol: AnyObject {
    var pageDataMovie: PageDataMovie? { get set }
    var updateData: VoidHendler? { get set }
    var showError: ((String, Bool, @escaping VoidHendler) -> ())? { get set }
    func loadData()
}

final class MenuViewModel: MenuViewModelProtocol {
    // MARK: - Internal properties

    var pageDataMovie: PageDataMovie?
    var updateData: VoidHendler?
    var showError: ((String, Bool, @escaping VoidHendler) -> ())?

    // MARK: - Private propertie

    private var stateView: ViewState<PageDataMovie> = .loading {
        didSet {
            switch stateView {
            case let .data(model):
                pageDataMovie = model
                updateData?()
            case .loading:
                break
            case let .error(errorType):
                pageDataMovie = nil
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

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
        loadData()
    }

    // MARK: - Internal function

    func loadData() {
        movieAPIService.fetchDataMovie { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                self.pageDataMovie = data
                self.updateData?()
                self.stateView = Bool.random() ? .error(.failure(DataError())) : .data(data)
            }
        }
    }
}

/// asdgf
struct DataError: Error {}
