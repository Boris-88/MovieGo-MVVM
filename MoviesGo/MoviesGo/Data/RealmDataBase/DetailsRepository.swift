// DetailsRepository.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

// репозиторий для модели DetailsMovie
final class DetailsRepository: RepositoryDetailsProtocol {
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
