//
//  Item+CoreDataProperties.swift
//  ProductList
//
//  Created by Alif on 22/09/2017.
//  Copyright © 2017 Alif. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var details: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var toImage: NSManagedObject?
    @NSManaged public var toItemType: NSManagedObject?
    @NSManaged public var toStore: NSManagedObject?

}
