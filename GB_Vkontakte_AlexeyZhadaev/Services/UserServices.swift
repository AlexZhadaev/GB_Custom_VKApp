//
//  UserServices.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 01.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import Alamofire

class UserServices {
    
    func getUserData(completion: @escaping ([UserItem]) -> Void) {
        let accessToken = Session.instance.token
        debugPrint("UserServisesToken: \(accessToken ?? "")")
        AF.request("https://api.vk.com/method/friends.get?fields=bdate,photo_100&access_token=\(accessToken ?? "")&v=5.124)").responseData { (response) in
            let data = response.data!
            
            let decoder = JSONDecoder()
            
            let userData = try? decoder.decode(UserModel.self, from: data).items
            debugPrint("UserServises data: \(userData!)")
            completion(userData!)
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
    let firstname: String
    let lastname: String
    let avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case firstname = "first_name", lastname = "last_name", avatar = "photo_100"
    }
}
