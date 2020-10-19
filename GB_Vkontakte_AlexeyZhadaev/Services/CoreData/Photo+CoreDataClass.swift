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
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
            super.init(entity: entity, insertInto: context)
            print("Init called!")
        }
    
    func getPhotoData() {
        let id = Session.instance.userId
        let accessToken = Session.instance.token
        debugPrint("PhotoServisesToken: \(accessToken ?? "")")
        debugPrint("PhotoServisesId: \(id ?? 0)")
        AF.request("https://api.vk.com/method/photos.getAll?owner_id=\(id ?? 0)&extended=1&count=20&photo_sizes=1&access_token=\(accessToken ?? "")&v=5.124").responseData { (response) in
            let data = response.data!
            
            let decoder = JSONDecoder()
            
            let photoData = try! decoder.decode(PhotoModel.self, from: data).response.items
            self.savePhotoService.deleteEntityList(entity: "Photo")
            for item in photoData {
                self.savePhotoService.savePhoto(userLikes: item.likes.userLikes, likesCount: item.likes.count, url: item.sizes[4].url)
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
