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

    
    
    init(author : User, text : String){
        self.author = author
        self.text = text
        

        
    }
    init(author : User, text : String, parent : Comment){
        self.author = author
        self.text = text
        self.parent = parent
        

        
    }
}
