// Repository.swift
// Copyright © Boris. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    func getObjectMovie(object: [Movie]?) -> [Movie]?
    func saveObjectMovie(object: [Movie])
    func deleteObjectMovie(object: [Movie])
    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]?
    func saveObjectDetailsMovie(object: [DetailsMovie])
    func deleteObjectDetailsMovie(object: [DetailsMovie])
}

/// Repository
class Repository: RepositoryProtocol {
    private let realmDataBase = RealmDataBase()

    // репозиторий для модели DetailsMovie
    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]? {
        realmDataBase.getObjectFromRealm(object: object)
    }

    func saveObjectDetailsMovie(object: [DetailsMovie]) {
        realmDataBase.saveObjectToRealm(object: object)
    }

    func deleteObjectDetailsMovie(object: [DetailsMovie]) {
        realmDataBase.deleteObjectRealm(object: object)
    }

    // репозиторий для модели Movie
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
