//
//  Thread+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/11/21.
//
//

import Foundation
import CoreData


extension Thread {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thread> {
        return NSFetchRequest<Thread>(entityName: "Thread")
    }

    @NSManaged private var comments: [Comment]?
    @NSManaged public var name: String?

}

extension Thread : Identifiable {

}
