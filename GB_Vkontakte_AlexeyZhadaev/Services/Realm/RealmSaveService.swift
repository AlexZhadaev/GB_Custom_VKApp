//
//  RealmSaveService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 18.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import RealmSwift

class UserObject: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var avatar = ""
    @objc dynamic var id: Int = 0
}

class RealmSaveService: SaveServiceInterface {
    
    let realm: Realm
    
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        realm = try! Realm(configuration: config)
    }
    
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int) {
        let user = UserObject()
        user.firstName = firstName
        user.lastName = lastName
        user.avatar = avatar
        user.id = id
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    func readUserList(completion: @escaping ([UserEntity]) -> Void) {
        let realm = try! Realm()
        let list = realm.objects(UserObject.self)
        completion (list.map {UserEntity (firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar, id:  $0.id) } )
    }
    
    func deleteEntityList(entity: String) {

    }
    
    func saveGroup(name: String, avatar: String) {

    }
    
    func readGroupList(completion: @escaping ([GroupEntity]) -> Void) {

    }
    
    func savePhoto(userLikes: Int, likesCount: Int, url: String) {

    }
    
    func readPhotoList(completion: @escaping ([PhotoEntity]) -> Void) {

    }
}
