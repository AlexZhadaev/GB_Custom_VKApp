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
    
    let storeStack = CoreDataStack(modelName: "")

    
    func saveUser(firstName: String, lastName: String, avatar: String, id: Int) {
        let context = storeStack.context
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.avatar = avatar
        user.id = Int16(id)
        storeStack.saveContext()
    }
    
    func readUserList() -> [User] {
        let context = storeStack.context
        
        return (try? context.fetch(User.fetchRequest()) as? [User]) ?? []
    }
    
    func deleteEntityList(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try storeStack.context.execute(batchDeleteRequest)
        } catch {}
        storeStack.saveContext()
    }
    
    func saveGroup(name: String, avatar: String) {
        let context = storeStack.context
        let group = Group(context: context)
        group.name = name
        group.avatar = avatar
        storeStack.saveContext()
    }
    
    func readGroupList() -> [Group] {
        let context = storeStack.context
        
        return (try? context.fetch(Group.fetchRequest()) as? [Group]) ?? []
    }
    
    func savePhoto(userLikes: Int, likesCount: Int, url: String) {
        let context = storeStack.context
        let photo = Photo(context: context)
        photo.userLikes = Int16(userLikes)
        photo.likesCount = Int16(likesCount)
        photo.url = url
        storeStack.saveContext()
    }
    
    func readPhotoList() -> [Photo] {
        let context = storeStack.context
        
        return (try? context.fetch(User.fetchRequest()) as? [Photo]) ?? []
    }
}
