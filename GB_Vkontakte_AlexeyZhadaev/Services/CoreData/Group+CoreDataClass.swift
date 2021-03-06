//
//  Group+CoreDataClass.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData
import Alamofire

@objc(Group)
public class Group: NSManagedObject {
    let saveGroupService = CoreDataSaveService()
    
    func getGroupData(completion: @escaping () -> Void) {
        guard let accessToken = Session.instance.token else {
            debugPrint("No access token in getGroupData")
            return
        }
        
        AF.request("https://api.vk.com/method/groups.get?extended=1&fields=name,photo_100&access_token=\(accessToken)&v=5.124").responseData { (response) in
            guard let data = response.data else {
                debugPrint("No data from AF.request in getGroupData")
                return
            }
            
            let decoder = JSONDecoder()
            
            let groupData = try! decoder.decode(GroupModel.self, from: data).items
            self.saveGroupService.deleteEntityList(entity: "Group")
            for item in groupData {
                self.saveGroupService.saveGroup(name: item.name, avatar: item.avatar)
                completion()
            }
        }
    }
    
    func getSearchGroups(completion: @escaping () -> Void) {
        guard let accessToken = Session.instance.token else {
            debugPrint("No access token in getSearchGroups")
            return
        }
        
        AF.request("https://api.vk.com/method/groups.search?q=music&type=group&access_token=\(accessToken)&v=5.124").responseData { (response) in
            guard let data = response.data else {
                debugPrint("No data from AF.request in getSearchGroups")
                return
            }
            
            let decoder = JSONDecoder()
            
            let groupData = try! decoder.decode(GroupModel.self, from: data).items
            self.saveGroupService.deleteEntityList(entity: "Group")
            for item in groupData {
                self.saveGroupService.saveGroup(name: item.name, avatar: item.avatar)
                completion()
            }
        }
    }
}

struct GroupModel: Decodable {
    let items: [Item]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let responseValues = try values.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        items = try responseValues.decode([Item].self, forKey: .items)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseKeys: String, CodingKey {
        case items
    }
}

struct Item: Codable {
    let name: String
    let avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", avatar = "photo_100"
    }
}
