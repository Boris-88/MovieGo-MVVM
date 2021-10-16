// RealmDataBase.swift
// Copyright © Boris. All rights reserved.

import Foundation
import RealmSwift
protocol RealmDataBaseProtocol: AnyObject {
    func deleteObjectRealm<T: Object>(object: [T])
    func saveObjectToRealm<T: Object>(object: [T])
    func getObjectFromRealm<T: Object>(object: [T]?) -> [T]?
}

final class RealmDataBase: RealmDataBaseProtocol {
    func saveObjectToRealm<T: Object>(object: [T]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func getObjectFromRealm<T: Object>(object: [T]?) -> [T]? {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(T.self)
            var entityArray: [T] = []
            realmObjects.forEach {
                entityArray.append($0)
            }
            return entityArray
        } catch {
            return []
        }
    }

    func deleteObjectRealm<T: Object>(object: [T]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
