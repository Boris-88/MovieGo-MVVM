// MenuRepository.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol RepositoryMenuProtocol: AnyObject {
    func getObjectMovie(object: [Movie]?) -> [Movie]?
    func saveObjectMovie(object: [Movie])
    func deleteObjectMovie(object: [Movie])
}

// репозиторий для модели Movie
class MenuRepository: RepositoryMenuProtocol {
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
