//
//  User+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/11/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var correctAnswered: Int64
    @NSManaged public var password: String?
    @NSManaged public var subscribed: Bool
    @NSManaged public var totalAnswered: Int64
    @NSManaged public var username: String?
    @NSManaged private var comments: [Comment]?
    @NSManaged public var user: NSSet?
    @NSManaged public var isBlocked : Bool
    @NSManaged public var quizzesLeft : Int64

}

// MARK: Generated accessors for user
extension User {
    
    func getComments() -> [Comment]? {
        return comments
    }

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: QuizAnswer)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: QuizAnswer)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension User : Identifiable {

}
