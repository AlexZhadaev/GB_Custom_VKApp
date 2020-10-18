//
//  SaveServiceProtocol.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 18.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

struct UserEntity {
    let firstName: String
    let lastName: String
    let avatar: String
    let id: Int
}

struct GroupEntity {
    let name: String
    let avatar: String
}

struct PhotoEntity {
    let userLikes: Int
    let likesCount: Int
    let url: String
}

protocol SaveServiceInterface {
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int)
    func readUserList(completion: @escaping ([UserEntity]) -> Void)
    func saveGroup(name: String, avatar: String)
    func readGroupList(completion: @escaping ([GroupEntity]) -> Void)
    func savePhoto(userLikes: Int, likesCount: Int, url: String)
    func readPhotoList(completion: @escaping ([PhotoEntity]) -> Void)
    func deleteEntityList(entity: String)
}
