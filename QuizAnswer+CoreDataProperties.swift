//
//  QuizAnswer+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/11/21.
//
//

import Foundation
import CoreData


extension QuizAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizAnswer> {
        return NSFetchRequest<QuizAnswer>(entityName: "QuizAnswer")
    }

    @NSManaged public var answers: NSObject?
    @NSManaged public var questions: NSObject?
    @NSManaged public var user: User?

}

extension QuizAnswer : Identifiable {

}
