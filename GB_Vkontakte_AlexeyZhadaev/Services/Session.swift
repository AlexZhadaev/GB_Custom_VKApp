//
//  Session.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 22.09.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    var token: String?
    var userId: Int?
    
    private init() {}
}

