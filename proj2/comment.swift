//
//  comment.swift
//  proj2
//
//  Created by admin on 5/11/21.
//

import Foundation

class Comment : NSObject {
    var author : User
    var text : String
    var parent : Comment?
    var replies : [Comment]?
    var thread : String

    
    
    init(author : User, text : String, thread : String){
        self.author = author
        self.text = text
        self.thread = thread
        

        
    }
    init(author : User, text : String, parent : Comment, thread : String){
        self.author = author
        self.text = text
        self.parent = parent
        self.thread = thread
        

        
    }
}
