//
//  StudentsTests.swift
//  StudentsTests
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import XCTest
import CoreData

@testable import Students

class BundleClass {}

class StudentsTests: XCTestCase {
    
    class func jsonDictionaryFromFile(_ filename: String) -> Dictionary<String, AnyObject> {
        let testBundle = Bundle(for: BundleClass.self)
        let path = testBundle.path(forResource: filename, ofType: "json")
        XCTAssertNotNil(path, "wrong filename")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        XCTAssertNotNil(data, "wrong filename")
        do {
            if let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String,AnyObject> {
                return jsonDictionary
            }
            
        } catch let error {
            print(error)
        }
        return [String :AnyObject]()
    }

    var managedObjectContext : NSManagedObjectContext {
        return ModelManager.sharedManager.persistentContainer.viewContext
    }
    
    override func setUp() {
        super.setUp()
        
        let students = Student.allObjects(inManagedObjectContext: managedObjectContext)
        
        for student in students {
            managedObjectContext.delete(student)
        }
        
        ModelManager.sharedManager.saveContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreate2Students() {
        
        let _ = Student.insertStudentWithName("Erik", inManagedObjectContext: managedObjectContext)
        let _ = Student.insertStudentWithName("Magnus", inManagedObjectContext: managedObjectContext)
        
        ModelManager.sharedManager.saveContext()
        
        let fetchedStudents = Student.allObjects(inManagedObjectContext: managedObjectContext)
        XCTAssertEqual(fetchedStudents.count, 2, "students should be 2")
        XCTAssert(fetchedStudents.count == 2)
        XCTAssertTrue(fetchedStudents.count == 2)
    }

    func testCreate1Student() {
        let _ = Student.insertStudentWithName("Erik", inManagedObjectContext: managedObjectContext)
        ModelManager.sharedManager.saveContext()
        let fetchedStudents = Student.allObjects(inManagedObjectContext: managedObjectContext)
        XCTAssertEqual(fetchedStudents.count, 1)
    }


    func testCreateStudentFromJSON () {
        let wantedName = "Marie Curie"
        let wantedGrade = 5
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1Student")
        
        let student = Student(attributes: jsonAttributes)
        ModelManager.sharedManager.saveContext()
        
        XCTAssertNotNil(student)
        
        XCTAssertEqual(student?.name, wantedName)
        XCTAssertEqual(student?.grade?.intValue, wantedGrade)
        
        let fetchedStudent = Student.allObjects(inManagedObjectContext: managedObjectContext).first!
        
        XCTAssertEqual(fetchedStudent.name, wantedName)
        XCTAssertEqual(fetchedStudent.grade?.intValue, wantedGrade)
        
    }
    
    func testShouldNotCreateStudent() {
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1FalseStudent")
        
        let student = Student(attributes: jsonAttributes)
        ModelManager.sharedManager.saveContext()
        
        XCTAssertNil(student)
    }


    func testAverageGradeForSingleStudent() {
        let student = Student.insertStudentWithName("Per", inManagedObjectContext: managedObjectContext)
        student.grade = 3

        ModelManager.sharedManager.saveContext()

        let averageGrade = Student.averageGrade()
        XCTAssertEqual(averageGrade, 3)
    }

    func testAverageGradeFor2Students() {
     let student = Student.insertStudentWithName("Per", inManagedObjectContext: managedObjectContext)
     let student2 = Student.insertStudentWithName("Monica", inManagedObjectContext: managedObjectContext)
        student.grade = 1
        student2.grade = 6

        ModelManager.sharedManager.saveContext()

        let averageGrade = Student.averageGrade()
        XCTAssertEqual(averageGrade, 3.5)
    }

    func testMeasureCreate1000Students() {
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1Student")
        measure { () -> Void in
            for _ in 0...1000 {
                let student = Student(attributes: jsonAttributes)
                XCTAssertNotNil(student)
            }
            ModelManager.sharedManager.saveContext()
        }
    }
    
}
