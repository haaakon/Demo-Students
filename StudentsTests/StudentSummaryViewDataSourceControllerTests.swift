//
//  StudentSummaryViewDataSourceControllerTests.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import XCTest
import CoreData
@testable import Students

class StudentSummaryViewDataSourceControllerTests: XCTestCase {
    
    var managedObjectContext : NSManagedObjectContext {
        return ModelManager.sharedManager.persistentContainer.viewContext
    }
    
    override func setUp() {
        super.setUp()
        let stud = Student.allObjects(inManagedObjectContext: managedObjectContext)
        
        for student in stud {
            managedObjectContext.delete(student)
        }
        
        ModelManager.sharedManager.saveContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func mockInsertStudents(_ names : [String]) -> [Student] {
        let insertedStudents =  names.map { (name) -> Student in
            let student = Student.insertStudentWithName(name, inManagedObjectContext: managedObjectContext)
            
            return student
        }
        
        ModelManager.sharedManager.saveContext()
        
        return insertedStudents
    }
    
    
}
