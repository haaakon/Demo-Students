//
//  Student.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import Foundation
import CoreData

@objc
final class Student: NSManagedObject, Fetchable {
    
    static var entityName = "Student"
    
    static func insertStudentWithName(name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Student {
        let student = Student(entity: NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)!, insertIntoManagedObjectContext: managedObjectContext)
        student.name = name
        return student
    }
    
    convenience init?(attributes: [String: AnyObject], inManagedObjectContext managedObjectContext: NSManagedObjectContext = ModelManager.sharedManager.managedObjectContext) {
        
        
        guard let actualName = attributes["name"] as? String else {
            return nil
        }
        
        guard let actualGrade = attributes["grade"] as? NSNumber else {
            return nil
        }
        
        self.init(entity: NSEntityDescription.entityForName(Student.entityName, inManagedObjectContext: managedObjectContext)!, insertIntoManagedObjectContext: managedObjectContext)
        self.name = actualName
        self.grade = actualGrade
        
        
    }
    
    
    
}
