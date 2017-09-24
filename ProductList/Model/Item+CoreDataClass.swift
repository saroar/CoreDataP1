//
//  Item+CoreDataClass.swift
//  ProductList
//
//  Created by Alif on 22/09/2017.
//  Copyright © 2017 Alif. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        self.created = NSDate()
    
    }
}
