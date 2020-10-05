//
//  GroupServices.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 01.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import Alamofire

class GroupServices {
    
    func getGroupData(completion: @escaping ([Item]) -> Void) {
        let accessToken = Session.instance.token
        debugPrint("GroupToken: \(accessToken ?? "")")
        AF.request("https://api.vk.com/method/groups.get?extended=1&fields=name,photo_100&access_token=\(accessToken ?? "")&v=5.124)").responseData { (response) in
            let data = response.data!
            
            let decoder = JSONDecoder()
            
            let groupData = try? decoder.decode(GroupModel.self, from: data).items
            debugPrint(groupData as Any)
            completion(groupData!)
        }
    }
    
    func getSearchGroups(completion: @escaping ([Item]) -> Void) {
        let accessToken = Session.instance.token
        debugPrint("GroupToken: \(accessToken ?? "")")
        AF.request("https://api.vk.com/method/groups.search?q=music&type=group&access_token=\(accessToken ?? "")&v=5.124)").responseData { (response) in
            let data = response.data!
            
            let decoder = JSONDecoder()
            
            let groupData = try? decoder.decode(GroupModel.self, from: data).items
            debugPrint(groupData as Any)
            completion(groupData!)
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
