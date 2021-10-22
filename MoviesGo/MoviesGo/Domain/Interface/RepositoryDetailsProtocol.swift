// RepositoryDetailsProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

protocol RepositoryDetailsProtocol: AnyObject {
    func getObjectDetailsMovie(object: [DetailsMovie]?) -> [DetailsMovie]?
    func saveObjectDetailsMovie(object: [DetailsMovie])
    func deleteObjectDetailsMovie(object: [DetailsMovie])
}
