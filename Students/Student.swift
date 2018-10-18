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
    
    static func insertStudentWithName(_ name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Student {
        let student = Student(entity: NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!, insertInto: managedObjectContext)
        student.name = name
        return student
    }

    static func averageGrade(inManagedObjectContext managedObjectContext: NSManagedObjectContext = ModelManager.sharedManager.persistentContainer.viewContext) -> Float {
        let students = Student.allObjects(inManagedObjectContext: managedObjectContext)

        var totalGrade : Float = 0
        for student in students {
            totalGrade += student.grade!.floatValue
        }
        return totalGrade / Float(students.count)

    }
    
    convenience init?(attributes: [String: AnyObject], inManagedObjectContext managedObjectContext: NSManagedObjectContext = ModelManager.sharedManager.persistentContainer.viewContext) {
        
        
        guard let actualName = attributes["name"] as? String else {
            return nil
        }
        
        guard let actualGrade = attributes["grade"] as? NSNumber else {
            return nil
        }
        
        self.init(entity: NSEntityDescription.entity(forEntityName: Student.entityName, in: managedObjectContext)!, insertInto: managedObjectContext)
        self.name = actualName
        self.grade = actualGrade
        
        
    }
    
    
    
}
