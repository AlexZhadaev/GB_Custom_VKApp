//
//  CoreDataService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSaveService: SaveServiceInterface {
    
    lazy var storeStack = CoreDataStack(modelName: "GB_Vkontakte_AlexeyZhadaev")
    
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int) {
        let context = storeStack.context
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.avatar = avatar
        user.id = Int64(id)
        storeStack.saveContext()
    }
    
    func readUserList(completion: @escaping ([UserEntity]) -> Void) {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        completion (objects.map { UserEntity(firstName: $0.firstName ?? "", lastName: $0.lastName ?? "", avatar: $0.avatar ?? "", id: Int($0.id)) } )
    }
    
    func deleteEntityList(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try storeStack.context.execute(batchDeleteRequest)
        } catch {}
    }
    
    func saveGroup(name: String, avatar: String) {
        let context = storeStack.context
        let group = Group(context: context)
        group.name = name
        group.avatar = avatar
        storeStack.saveContext()
    }
    
    func readGroupList(completion: @escaping ([GroupEntity]) -> Void) {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        completion (objects.map { GroupEntity(name: $0.name ?? "", avatar: $0.avatar ?? "") } )
    }
    
    func savePhoto(userLikes: Int, likesCount: Int, url: String) {
        let context = storeStack.context
        let photo = Photo(context: context)
        photo.userLikes = Int16(userLikes)
        photo.likesCount = Int16(likesCount)
        photo.url = url
        storeStack.saveContext()
    }
    
    func readPhotoList(completion: @escaping ([PhotoEntity]) -> Void) {
        let context = storeStack.context
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        completion (objects.map { PhotoEntity(userLikes: Int($0.userLikes), likesCount: Int($0.likesCount), url: $0.url ?? "") } )
    }
}
