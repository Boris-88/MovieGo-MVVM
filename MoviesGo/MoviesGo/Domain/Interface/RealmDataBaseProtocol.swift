// RealmDataBaseProtocol.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation
import RealmSwift

protocol RealmDataBaseProtocol: AnyObject {
    func deleteObjectRealm<T: Object>(object: [T])
    func saveObjectToRealm<T: Object>(object: [T])
    func getObjectFromRealm<T: Object>(object: [T]?) -> [T]?
}
