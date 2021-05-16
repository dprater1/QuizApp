//
//  QuizAnswer+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/15/21.
//
//

import Foundation
import CoreData


extension QuizAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizAnswer> {
        return NSFetchRequest<QuizAnswer>(entityName: "QuizAnswer")
    }

    @NSManaged public var answers: [String]?
    @NSManaged public var questions: [Question]?
    @NSManaged public var quizname: String?
    @NSManaged public var user: User?
    @NSManaged public var correct: Int16
    

}

extension QuizAnswer : Identifiable {

}
