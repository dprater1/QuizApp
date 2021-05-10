//
//  Quiz+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/10/21.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged private var questions: [Question]?

}

extension Quiz : Identifiable {

}
