//
//  PhotoServices.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 04.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import Alamofire

class PhotoItem: Decodable {
    var id = Session.instance.userId
    dynamic var url = ""
    dynamic var userLikes = 0
    dynamic var likesCount = 0
    
        convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let responseValues = try values.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        var itemsValues = try responseValues.nestedUnkeyedContainer(forKey: .items)
        let firstItemsValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)
        var sizesValues = try firstItemsValues.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizesValues = try sizesValues.nestedContainer(keyedBy: SizesKeys.self)
        self.url = try firstSizesValues.decode(String.self, forKey: .url)
        let likesValues = try firstItemsValues.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        self.userLikes = try likesValues.decode(Int.self, forKey: .userLikes)
        self.likesCount = try likesValues.decode(Int.self, forKey: .likesCount)
    }


    enum CodingKeys: String, CodingKey {
        case response
    }

    enum ResponseKeys: String, CodingKey {
        case items
    }

    enum ItemsKeys: String, CodingKey {
        case sizes
        case likes
    }

    enum SizesKeys: String, CodingKey {
        case url = "url"
    }

    enum LikesKeys: String, CodingKey {
        case userLikes = "user_likes"
        case likesCount = "count"
    }

    func getPhotoData(completion: @escaping ([PhotoItem]) -> Void) {
        let accessToken = Session.instance.token
        debugPrint("PhotoServisesToken: \(accessToken ?? "")")
        AF.request("https://api.vk.com/method/photos.getAll?owner_id=1207149&extended=1&count=2&photo_sizes=1&access_token=\(accessToken ?? "")&v=5.124)").responseData { (response) in
            let data = response.data!

            let decoder = JSONDecoder()

            let photoData = try? decoder.decode(Response.self, from: data).items
            debugPrint("Photo data: \(photoData!)")
            completion(photoData!)
        }
    }
    
}

class Response: Decodable {
    let items: [PhotoItem]
}

class Items: Decodable {
    let sizes: [PhotoItem]
}