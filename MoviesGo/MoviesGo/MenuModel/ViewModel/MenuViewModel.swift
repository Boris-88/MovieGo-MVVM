// MenuViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol MenuViewModelProtocol: AnyObject {
    var updateViewData: VoidHendler? { get set }
    var pageDataMovie: PageDataMovie? { get set }
    func loadData()
}

final class MenuViewModel: MenuViewModelProtocol {
    // MARK: - Internal properties

    var updateViewData: VoidHendler?
    var pageDataMovie: PageDataMovie?

    // MARK: - Private properties

    private var networkLayer: NetWorkLayer?

    // MARK: - Internal function

    func loadData() {
        networkLayer?.fetchData(PageDataMovie.self, methodStr: "movie/popular") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                switch error {
                case let .failure(error):
                    print("Ошибка связи с Бэк Error: \(error.localizedDescription)")
                case .failureDecode:
                    print("Ошибка декодирования")
                case .notData:
                    print("Отсуствуют данные")
                }
            case let .success(data):
                self.pageDataMovie = data
                self.updateViewData?()
            }
        }
    }
}
