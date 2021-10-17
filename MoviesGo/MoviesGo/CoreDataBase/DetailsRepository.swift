// DetailsRepository.swift
// Copyright © Boris. All rights reserved.

import Foundation

protocol RepositoryDetailsProtocol: AnyObject {
    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]?
    func saveObjectDetailsMovie(object: [DetailsMovie])
    func deleteObjectDetailsMovie(object: [DetailsMovie])
}

// репозиторий для модели DetailsMovie
class DetailsRepository: RepositoryDetailsProtocol {
    private let realmDataBase = RealmDataBase()

    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]? {
        realmDataBase.getObjectFromRealm(object: object)
    }

    func saveObjectDetailsMovie(object: [DetailsMovie]) {
        realmDataBase.saveObjectToRealm(object: object)
    }

    func deleteObjectDetailsMovie(object: [DetailsMovie]) {
        realmDataBase.deleteObjectRealm(object: object)
    }
}
