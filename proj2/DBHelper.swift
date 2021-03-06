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
    var ud = UserDefaults.standard
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func addNewUser(object : [String:String]){
        
       
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = object["username"]
        //print(user.username)
        if object.index(forKey: "password") == nil {
            print("creating fb user")
        } else {
            user.password = object["password"]
        }
        user.totalAnswered = 0
        user.correctAnswered = 0
        user.subscribed = false
        user.isBlocked = false
        user.quizzesLeft = 2

        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func addNewReview(object : String){
        
       
        let newRev = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context!) as! Review
        newRev.review = object

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
    func fetchUser( query : String) -> User?{
        var neededUser : User?
        DBHelper.dataCheck = false
        var fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", query)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.username == query){
                    neededUser = data
                    DBHelper.dataCheck = true
                    return neededUser
                }
                else {
                    continue
                }
            }
            return neededUser
        }
        catch{
            return neededUser
        }
    }
    
    func fetchAllUser() -> [User] {
        var allUsers : [User] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users {
                if data.username == "Admin" {
                    print("skipping admin")
                } else {
                    allUsers.append(data)
                }
            }
        } catch let error{
            print("error: ", error)
        }
        return allUsers
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
                    ud.setValue(user.isBlocked, forKey: "currUserBlocked")
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
    func subscribe(query : String){
        let user = DBHelper.inst.fetchUser(query: query)
        user?.subscribed = true
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func changeAccess(query : String) -> Bool {
           
           let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
           
           fetchReq.predicate = NSPredicate(format: "username == %@", query)
           
           do{
            let usr = try context!.fetch(fetchReq)
               for data in usr{
                   let user = data as! User
                user.isBlocked = !user.isBlocked
                do{
                    try context!.save()
                    print("data saved")
                }
                catch{
                    print("data not saved")
                }
                return user.isBlocked
           }
           }
           catch let error{
               print("error: ", error)
           }
        return false
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


    func quizExists(title : String) -> Bool {
        var fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        fetchReq.predicate = NSPredicate(format: "name == %@", title)
        do{
            let quiz = try context!.fetch(fetchReq)
            let quizzes = quiz as! [Quiz]
            for data in quizzes {
                if(data.name == title){
                    return true
                } else {
                    continue
                }
            }
            return false
        } catch {
            return false
        }
    }
    
    func addQuiz(title: String, question : [Question]) {
      
        let quiz = NSEntityDescription.insertNewObject(forEntityName: "Quiz", into: context!) as! Quiz
        quiz.name = title
        quiz.questions = question
        do{
            try context!.save()
            print("data saved")
        }catch{
            print("data not saved")
        }
    }
    func getQuiz(query : String) -> Quiz?{
        var quiz : Quiz?
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Quiz")
        
        fetchReq.predicate = NSPredicate(format: "name == %@", query)
        do{
         let thread = try context!.fetch(fetchReq)
            for data in thread{
                quiz = data as? Quiz
                return quiz
            }
        }
        catch let error{
            print("error: ", error)
            
            
        }
        return quiz
    }
    
    func addQuizAnswer(user : String, name: String, questions : [Question], answer: [String], right : Int){
        var currUser : User?
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", user)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.username == user){
                    currUser = data
                }else {continue}}}
                catch{
                    print("Error getting the current user")
                }
        DBHelper.dataCheck = false
        let oldQuizAns = getQuizAnswer(user: user, quiz: name)
        if(DBHelper.dataCheck){
            if(oldQuizAns!.correct <= right){
                let quizAns = NSEntityDescription.insertNewObject(forEntityName: "QuizAnswer", into: context!) as! QuizAnswer
                quizAns.quizname = name
                quizAns.questions = questions
                quizAns.answers = answer
                quizAns.user = currUser
                quizAns.correct = Int16(right)
                currUser!.correctAnswered  -= Int64(oldQuizAns!.correct)
                currUser!.correctAnswered += Int64(right)
                
            }
        }
        else{
            let quizAns = NSEntityDescription.insertNewObject(forEntityName: "QuizAnswer", into: context!) as! QuizAnswer
            quizAns.quizname = name
            quizAns.questions = questions
            quizAns.answers = answer
            quizAns.user = currUser
            if (currUser!.quizzesLeft > 0){
                currUser!.quizzesLeft -= 1
            }
            quizAns.correct = Int16(right)
            currUser!.correctAnswered += Int64(right)
        }
        
        
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        } 
        
        
        
        
    }
    func getQuizAnswer(user : String, quiz : String) -> QuizAnswer?{
        var currUser = DBHelper.inst.fetchUser(query: user)
        var quizAnswer : QuizAnswer?
        DBHelper.dataCheck = false
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "QuizAnswer")
        
        fetchReq.predicate = NSPredicate(format: "quizname == %@", quiz)
        do{
         let quized = try context!.fetch(fetchReq) as! [QuizAnswer]
            for data in quized{
                if (data.user == currUser){
                    quizAnswer = data
                    DBHelper.dataCheck = true
                    return quizAnswer
                }
            }
        }
        catch let error{
            print("error: ", error)            
        }
        return quizAnswer
    }
    func fetchAllQuiz() -> [Quiz] {
        var allQuizzes : [Quiz] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        do {
            let quiz = try context!.fetch(fetchReq)
            let quizzess = quiz as! [Quiz]
            for data in quizzess {
                allQuizzes.append(data)
            }
        } catch let error{
            print("error: ", error)
        }
        return allQuizzes
    }
    func fetchAllQuizAnswer(quiz : String) -> [QuizAnswer] {
        var allQuizAnswers : [QuizAnswer] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "QuizAnswer")
        fetchReq.predicate = NSPredicate(format: "quizname == %@", quiz)
        do {
            let quiz = try context!.fetch(fetchReq)
            let quizzes = quiz as! [QuizAnswer]
            return quizzes
        } catch let error{
            print("error: ", error)
        }
        return allQuizAnswers
    }
    func resetAllEntities(_ entity : String){
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteReq = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do{
                try context?.execute(deleteReq)
                try context?.save()

            }
            catch {
                print("error")
            }
        }
}
