//
//  question.swift
//  proj2
//
//  Created by Bruno Gomez on 5/16/21.
//

import Foundation


public class Question : NSObject, NSCoding {
    var question : String = ""
    var a : String = ""
    var b : String = ""
    var c : String = ""
    var d : String = ""
    var correct : String = ""
    
    init(question : String, a : String, b : String, c : String, d : String, correct : String) {
        self.question = question
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.correct = correct
    }
    public func encode(with coder: NSCoder) {
        coder.encode(question, forKey: "question")
        coder.encode(a, forKey: "a")
        coder.encode(b, forKey: "b")
        coder.encode(c, forKey: "c")
        coder.encode(d, forKey: "d")
        coder.encode(correct, forKey: "correct")
    }
    
    required public init?(coder decod: NSCoder) {
        self.question = decod.decodeObject(forKey: "question") as! String
        self.a = decod.decodeObject(forKey: "a") as! String
        self.b = decod.decodeObject(forKey: "b") as! String
        self.c = decod.decodeObject(forKey: "c") as! String
        self.d = decod.decodeObject(forKey: "d") as! String
        self.correct = decod.decodeObject(forKey: "correct") as! String
        
    }
    
}
