//
//  Friend.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import Foundation

struct Friend: Equatable {
    let name: String
    let friendPhoto: String
    let friendGallery: [String]
}
/*
Нормально реализовать загрузку галлереи из массива не получилось, т.к. все уперлось в нежелание, например, подобного конфигура работать с [String]

func configure(for model: Friend) {
photoGallery.image = UIImage.init(named: model.friendGallery)

*/
