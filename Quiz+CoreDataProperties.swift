//
//  Quiz+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/13/21.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var questions: [String]?
    @NSManaged public var name: String?

}

extension Quiz : Identifiable {

}
