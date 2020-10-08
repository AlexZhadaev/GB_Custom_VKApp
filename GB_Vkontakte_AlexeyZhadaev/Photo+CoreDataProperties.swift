//
//  Photo+CoreDataProperties.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 08.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var userLikes: Int16
    @NSManaged public var likesCount: Int16
    @NSManaged public var url: String?

}

extension Photo : Identifiable {

}
