//
//  comment.swift
//  proj2
//
//  Created by admin on 5/11/21.
//

import Foundation

public class Comment : NSObject, NSCoding {
    
    var author : String
    var text : String
    var parent : Comment?
    var replies : [Comment]?
    var thread : String

    
    
    init(author : String, text : String, thread : String){
        self.author = author
        self.text = text
        self.thread = thread
        self.replies = []

        
    }
    init(author : String, text : String, parent : Comment, thread : String){
        self.author = author
        self.text = text
        self.parent = parent
        self.thread = thread

        
    }
    public func encode(with coder: NSCoder) {
        coder.encode(author, forKey: "author")
        coder.encode(text, forKey: "text")
        coder.encode(parent, forKey: "parent")
        coder.encode(replies, forKey: "replies")
        coder.encode(thread, forKey: "thread")
    }
    
    required public init?(coder decod: NSCoder) {
        self.author = decod.decodeObject(forKey: "author") as! String
        self.text = decod.decodeObject(forKey: "text") as! String
        self.parent = decod.decodeObject(forKey: "parent") as? Comment
        self.replies = decod.decodeObject(forKey: "replies") as? [Comment]
        self.thread = decod.decodeObject(forKey: "thread") as! String
        
    }
    
    
    
}
