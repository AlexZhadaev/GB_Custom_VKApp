//
//  CoreDataService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    let storeStack = CoreDataStack(modelName: "GB_Vkontakte_AlexeyZhadaev")
    
    
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int) {
        let context = storeStack.context
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.avatar = avatar
        user.id = Int64(id)
        storeStack.saveContext()
    }
    
    func readUserList(completion: @escaping ([User]) -> Void) {
        let context = storeStack.context
        
        completion (try! context.fetch(User.fetchRequest()) as! [User])
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
    
    func readGroupList(completion: @escaping ([Group]) -> Void) {
        let context = storeStack.context
        
        completion (try! context.fetch(Group.fetchRequest()) as! [Group])
    }
    
    func savePhoto(userLikes: Int, likesCount: Int, url: String) {
        let context = storeStack.context
        let photo = Photo(context: context)
        photo.userLikes = Int16(userLikes)
        photo.likesCount = Int16(likesCount)
        photo.url = url
        storeStack.saveContext()
    }
    
    func readPhotoList(completion: @escaping ([Photo]) -> Void) {
        let context = storeStack.context
        
        completion (try! context.fetch(Photo.fetchRequest()) as! [Photo])
    }
}
