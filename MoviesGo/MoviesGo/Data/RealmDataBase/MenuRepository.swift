// MenuRepository.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

// репозиторий для модели Movie
final class MenuRepository: RepositoryMenuProtocol {
    private let realmDataBase = RealmDataBase()

    func getObjectMovie(object: [Movie]?) -> [Movie]? {
        realmDataBase.getObjectFromRealm(object: object)
    }

    func saveObjectMovie(object: [Movie]) {
        realmDataBase.saveObjectToRealm(object: object)
    }

    func deleteObjectMovie(object: [Movie]) {
        realmDataBase.deleteObjectRealm(object: object)
    }
}
