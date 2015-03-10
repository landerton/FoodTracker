//
//  USDAItem.swift
//  FoodTracker
//
//  Created by Landon Anderton on 3/9/15.
//  Copyright (c) 2015 Landon Anderton. All rights reserved.
//

import Foundation
import CoreData

@objc(USDAItem)
class USDAItem: NSManagedObject {

    @NSManaged var calcium: String
    @NSManaged var carbohydrate: String
    @NSManaged var cholesterol: String
    @NSManaged var dateAdded: NSDate
    @NSManaged var energy: String
    @NSManaged var fatTotal: String
    @NSManaged var idValue: String
    @NSManaged var name: String
    @NSManaged var protein: String
    @NSManaged var sugar: String
    @NSManaged var vitaminC: String

}
