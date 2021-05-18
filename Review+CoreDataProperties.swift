//
//  Review+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/18/21.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var review: String?

}

extension Review : Identifiable {

}
