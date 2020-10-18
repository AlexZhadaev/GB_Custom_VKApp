//
//  RealmSaveService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 18.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

class RealmSaveService: SaveServiceInterface {
    
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int) {

    }
    
    func readUserList(completion: @escaping ([UserEntity]) -> Void) {

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
