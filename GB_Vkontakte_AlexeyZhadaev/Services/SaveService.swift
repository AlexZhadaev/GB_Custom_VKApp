//
//  SaveService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 05.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

class SaveService {
    
    func save(value: String, for key: String) {
        UserDefaults.standard.setValue("Test", forKey: "my_key")
    }
    
    func read(for key: String) -> String {
        return UserDefaults.standard.string(forKey: "my_key")
    }
}
