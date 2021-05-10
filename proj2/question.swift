//
//  question.swift
//  Project2
//
//  Created by admin on 5/10/21.
//

import Foundation

class Question: NSObject {
    var question : String
    var a : String
    var b : String
    var c : String
    var d : String
    var correct : String
    
    
    init(quest : String , a : String, b : String, c : String, d : String, correct : String){
        question = quest
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.correct = correct
        
    }
}
