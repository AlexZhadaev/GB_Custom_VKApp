//
//  User+CoreDataClass.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData
import Alamofire

@objc(User)
public class User: NSManagedObject, NSFetchedResultsControllerDelegate {
    let saveUserService = CoreDataSaveService()
    
    lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedContext = saveUserService.storeStack.context

        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultsController = NSFetchedResultsController<User>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
      }()
    
    func getUserData() {
        let accessToken = Session.instance.token
        debugPrint("UserServisesToken: \(accessToken ?? "")")
        AF.request("https://api.vk.com/method/friends.get?fields=bdate,photo_100&access_token=\(accessToken ?? "")&v=5.124").responseData { (response) in
            let data = response.data!
            
            let decoder = JSONDecoder()
            
            let userData = try! decoder.decode(UserModel.self, from: data).items
            self.saveUserService.deleteEntityList(entity: "User")
            for item in userData {
                self.saveUserService.saveUser(firstName: item.firstName, lastName: item.lastName, avatar: item.avatar, id: item.id)
            }
        }
    }
}

struct UserModel: Decodable {
    let items: [UserItem]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let responseValues = try values.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        items = try responseValues.decode([UserItem].self, forKey: .items)
    }

    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseKeys: String, CodingKey {
        case items
    }
}

struct UserItem: Codable {
    let firstName: String
    let lastName: String
    let avatar: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name", lastName = "last_name", avatar = "photo_100", id = "id"
    }
}
