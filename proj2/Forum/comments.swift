//
//  comments.swift
//  proj2
//
//  Created by admin on 5/13/21.
//

import Foundation

public class Comments : NSObject, NSCoding{
    public var comments : [Comment] = []
    
    init(comments : [Comment]){
        self.comments = comments
    }
    public func encode(with cod :NSCoder){
        cod.encode(comments, forKey: "comments")
    }
    public required convenience init?(coder decod : NSCoder){
        let mComments = decod.decodeObject(forKey: "comments") as! [Comment]
        
        self.init(comments: mComments)
    }
}
