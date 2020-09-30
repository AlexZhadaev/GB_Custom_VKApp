//
//  VkService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 27.09.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation
import Alamofire



class VkFriendsService {
    let url = "api.vk.com"
    
    func loadFriendsData() {
        let accessToken = Session.instance.token
        AF.request("https://api.vk.com/method/friends.get?fields=bdate&access_token=\(accessToken ?? "")&v=5.124").responseJSON { response in
            
            debugPrint(response.value as Any)
            debugPrint("ServiceToken - \(accessToken ?? "")")
        }
    }
    
}

