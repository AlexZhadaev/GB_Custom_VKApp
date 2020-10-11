//
//  Group+CoreDataProperties.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 11.10.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var avatar: String?

}

extension Group : Identifiable {

}
