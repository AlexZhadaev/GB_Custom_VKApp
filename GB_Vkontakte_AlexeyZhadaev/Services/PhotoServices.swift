//
//  PhotoServices.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 04.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import Alamofire

struct PhotoService {
    func getPhotoData() {
            let id = Session.instance.userId
            let accessToken = Session.instance.token
            debugPrint("PhotoServisesToken: \(accessToken ?? "")")
            AF.request("https://api.vk.com/method/photos.getAll?owner_id=1207149&extended=1&count=2&photo_sizes=1&access_token=\(accessToken ?? "")&v=5.124)").responseData { (response) in
                let data = response.data!

                let decoder = JSONDecoder()

                let photoData = try? decoder.decode(PhotoModel.self, from: data)
                debugPrint("Photo data: \(photoData!)")

            }
        }
}

struct PhotoModel: Decodable {
    let response: Response
}

struct Response: Decodable {
    let items: [PhotoItem]
}

struct PhotoItem: Decodable {
    let sizes: [Size]
    let likes: Likes

    enum CodingKeys: String, CodingKey {
        case sizes, likes
    }
}

struct Likes: Decodable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

struct Size: Decodable {
    let url: String
}
