//
//  Thread+CoreDataProperties.swift
//  proj2
//
//  Created by admin on 5/13/21.
//
//

import Foundation
import CoreData


extension Thread {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thread> {
        return NSFetchRequest<Thread>(entityName: "Thread")
    }

    @NSManaged public var comments: Comments?
    @NSManaged public var name: String?
    
    func addComment(comment : Comment){
        comments?.comments.append(comment)
    }
    

}

extension Thread : Identifiable {

}
