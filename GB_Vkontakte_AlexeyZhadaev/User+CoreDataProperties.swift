//
//  User+CoreDataProperties.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 08.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var avatar: String?
    @NSManaged public var id: Int16

}

extension User : Identifiable {

}
