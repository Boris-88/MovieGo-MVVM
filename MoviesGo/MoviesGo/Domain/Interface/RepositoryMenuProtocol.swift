// RepositoryMenuProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

protocol RepositoryMenuProtocol: AnyObject {
    func getObjectMovie(object: [Movie]?) -> [Movie]?
    func saveObjectMovie(object: [Movie])
    func deleteObjectMovie(object: [Movie])
}
