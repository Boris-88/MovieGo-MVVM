// MenuViewModel.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

protocol MenuViewModelProtocol: AnyObject {
    var updateViewData: ((ViewState<PageDataMovie>) -> ())? { get set }
}

final class MenuViewModel: MenuViewModelProtocol {
    public var updateViewData: ((ViewState<PageDataMovie>) -> ())?
    var networkLayer: NetWorcLayer?

    init() {
        updateViewData?(.initial)
    }
    
    private func loadData() {
        networkLayer?.fetchData(PageDataMovie.self, methodStr: "movie/popular") { [weak self] result in
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
                self?.pageDataMovie = data
            }
        }
    }
}
