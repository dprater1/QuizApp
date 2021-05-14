//
//  DBHelper.swift
//  proj2
//
//  Created by admin on 5/10/21.
//

import Foundation
import CoreData
import UIKit

class DBHelper{
    static var inst = DBHelper()
    static var dataCheck = false
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func addNewUser(object : [String:String]){
        
       
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = object["username"]
        //print(user.username)
        user.password = object["password"]
        user.totalAnswered = 0
        user.correctAnswered = 0
        user.subscribed = false

        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    
    
    func userExist( query : String) -> Bool{
        
        
        var fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", query)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.username == query){
                    return true
                }
                else {
                    continue
                }
            }
            return false
        }
        catch{
            return false
        }
    }
    
    func validatePass(uName : String, uPass : String) -> Bool{
        
        //var user = UserD()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
       
        do{
            fetchReq.predicate =  NSPredicate(format: "username == %@", uName)
            
           
            let usr = try context!.fetch(fetchReq)
            for data in usr {
                let user = data as! User
                if(uName == user.username && uPass == user.password){
                    DBHelper.dataCheck = true
                    return true}
                else{continue}
                
                
            }
            DBHelper.dataCheck = false
            return false

           
        }
        catch{
            return false
        }
    }
    func changeAccess(query : String) {
           
           let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
           
           fetchReq.predicate = NSPredicate(format: "username == %@", query)
           
           do{
            let usr = try context!.fetch(fetchReq)
               for data in usr{
                   let user = data as! User
                   let val = user.value(forKey: "isBlocked") as! Bool
                       user.setValue(!val, forKey: "isBlocked")
               }
           }
           catch let error{
               print("error: ", error)
           }
       }
       
       
       
       func getCommentFromThread(query : String) -> [Comment]?{
           
           let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Thread")
           
           fetchReq.predicate = NSPredicate(format: "name == %@", query)
           do{
            let thread = try context!.fetch(fetchReq)
               for data in thread{
                   let curr = data as! Thread
                //print(curr.comments?.comments[0])
                return curr.comments?.comments
               }
           }
           catch let error{
               print("error: ", error)
               
           }
           return []
       }
    
    func addCommentToThread(comment : Comment){
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Thread")
        fetchReq.predicate = NSPredicate(format: "name == %@", comment.thread)
        do{
            print("a")
            var thr = try context!.fetch(fetchReq)
            print("B")
            if(thr.isEmpty){
                print("thread is empty")
                let thread = NSEntityDescription.insertNewObject(forEntityName: "Thread", into: context!) as! Thread
                thread.name = comment.thread
                do{
                    try context!.save()
                    print("data saved")
                }
                catch{
                    print("data not saved")
                }
            }
            thr = try context!.fetch(fetchReq)
            for data in thr{
                print("c")
                let thread = data as! Thread
                if((thread.comments) == nil){
                   
                    thread.comments = Comments(comments: [comment])
                }
                else{
                   
                    var array = thread.comments!.comments
                    array.append(comment)
                    thread.comments = Comments(comments: array)
                    print(thread.comments?.comments.count)
                    
                }
            do{
                try context!.save()
                thr = try context!.fetch(fetchReq)
                for data in thr{
                    let curr = data as! Thread
                 //print(curr.comments?.comments[0])
                    print(curr.comments?.comments)
                }
                //checkdata(comment: comment)
                //print(comment.author, comment.text)
                print("pthread size", thread.comments?.comments.count)
                
                print("data saved")
            }
            catch{
                print("data not saved")
            }
        
        }
        }
        catch{
            print("error: ")
        }
        
    }
    func replyToComment(comment : Comment, comloc : Int){
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Thread")
        fetchReq.predicate = NSPredicate(format: "name == %@", comment.thread)
        do{
            var thr = try context!.fetch(fetchReq)
            for data in thr{
                print("c")
                let thread = data as! Thread
                var array = thread.comments!.comments
                var currCom = array[comloc]
                currCom.replies?.append(comment)
                thread.comments = Comments(comments: array)
                //print(thread.comments?.comments.count)

            do{
                try context!.save()
                print("data saved")
            }
            catch{
                print("data not saved")
            }   
        }
        }
        catch{
            print("error: ")
        }
        
    }
//
//    func checkdata(comment : Comment){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Thread")
//
//        fetchReq.predicate = NSPredicate(format: "name == %@", comment.thread)
//        do{
//            let thread = try context.fetch(fetchReq)
//            for data in thread{
//                let curr = data as! Thread
//             //print(curr.comments?.comments[0])
//                print(curr.comments?.comments)
//            }
//        }
//        catch let error{
//            print("error: ", error)
//
//        }
//    }
}


func addQuiz(title: String, questions : Question) {
    let questionArr : [Question] = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
    let context = appDelegate.persistentContainer.viewContext
    let quiz = NSEntityDescription.insertNewObject(forEntityName: "Quiz", into: context) as! Quiz
    quiz.name = title
    quiz.questions = questionArr
    do{
        try context.save()
        print("data saved")
    }catch{
        print("data not saved")
    }
}

public class Question : NSObject {
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
}
