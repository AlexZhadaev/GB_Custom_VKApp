//
//  Photo+CoreDataClass.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData
import Alamofire

@objc(Photo)
public class Photo: NSManagedObject {
    let savePhotoService = CoreDataSaveService()
    
    func getPhotoData(completion: @escaping () -> Void) {
        guard let id = Session.instance.userId else {
            debugPrint("No id in getPhotoData")
            return
        }
        guard let accessToken = Session.instance.token else {
            debugPrint("No access token in getPhotoData")
            return
        }
        
        AF.request("https://api.vk.com/method/photos.getAll?owner_id=\(id)&extended=1&count=20&photo_sizes=1&access_token=\(accessToken)&v=5.124").responseData { (response) in
            guard let data = response.data else {
                debugPrint("No data from AF.request in getPhotoData")
                return
            }
            
            let decoder = JSONDecoder()
            
            let photoData = try! decoder.decode(PhotoModel.self, from: data).response.items
            self.savePhotoService.deleteEntityList(entity: "Photo")
            for item in photoData {
                self.savePhotoService.savePhoto(userLikes: item.likes.userLikes, likesCount: item.likes.count, url: item.sizes[4].url)
                completion()
            }
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
    var likes: Likes
    
    enum CodingKeys: String, CodingKey {
        case sizes, likes
    }
}

struct Likes: Decodable {
    var userLikes, count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

struct Size: Decodable {
    let url: String
}
