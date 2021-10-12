// MenuViewModel.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol MenuViewModelProtocol: AnyObject {
    var pageDataMovie: PageDataMovie? { get set }
    func loadData(_ completion: @escaping () -> (Void))
    var networkLayer: NetWorkLayer? { get set }
}

final class MenuViewModel: MenuViewModelProtocol {
    // MARK: - Internal properties

    var networkLayer: NetWorkLayer?
    var pageDataMovie: PageDataMovie?

    // MARK: - Internal function

    func loadData(_ completion: @escaping () -> (Void)) {
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
            }
        }
    }
}
