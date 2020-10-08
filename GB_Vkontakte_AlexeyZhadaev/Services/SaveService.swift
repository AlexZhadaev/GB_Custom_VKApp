//
//  SaveService.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 05.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

class LocalDataStore {
    
//    func save(value: String, for key: String) {
//        UserDefaults.standard.setValue(value, forKey: key)
//    }
//
//    func read(for key: String) -> String {
//        return UserDefaults.standard.string(forKey: key) ?? ""
//    }
    
    func save(value: String, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func read(for key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
