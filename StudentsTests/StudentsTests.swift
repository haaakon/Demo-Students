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

class StudentsTests: XCTestCase {
    
    class func jsonDictionaryFromFile(filename: String) -> Dictionary<String, AnyObject> {
        let testBundle = NSBundle(forClass: AppDelegate.self)
        let path = testBundle.pathForResource(filename, ofType: "json")
        XCTAssertNotNil(path, "wrong filename")
        let data = NSData(contentsOfFile: path!)
        XCTAssertNotNil(data, "wrong filename")
        do {
            if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? Dictionary<String,AnyObject> {
                return jsonDictionary
            }
            
        } catch let error {
            print(error)
        }
        return [String :AnyObject]()
    }
    
    
    var managedObjectContext : NSManagedObjectContext {
        return ModelManager.sharedManager.managedObjectContext
    }
    
    override func setUp() {
        super.setUp()
        
        let students = Student.allObjects(inManagedObjectContext: managedObjectContext)
        
        for student in students {
            managedObjectContext.deleteObject(student)
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
        XCTAssertEqual(fetchedStudents.count, 2)
    }
    
    func testCreateStudentFromJSON () {
        let wantedName = "Marie Curie"
        let wantedGrade = 5
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1Student")
        
        let student = Student(attributes: jsonAttributes)
        ModelManager.sharedManager.saveContext()
        
        XCTAssertNotNil(student)
        
        XCTAssertEqual(student?.name, wantedName)
        XCTAssertEqual(student?.grade, wantedGrade)
        
        let fetchedStudent = Student.allObjects(inManagedObjectContext: managedObjectContext).first!
        
        XCTAssertEqual(fetchedStudent.name, wantedName)
        XCTAssertEqual(fetchedStudent.grade, wantedGrade)
        
    }
    
    func testShouldNotCreateStudent() {
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1FalseStudent")
        
        let student = Student(attributes: jsonAttributes)
        ModelManager.sharedManager.saveContext()
        
        XCTAssertNil(student)
        
    }
    
    
    func testMeasureCreate1000Students() {
        let jsonAttributes = StudentsTests.jsonDictionaryFromFile("1Student")
        measureBlock { () -> Void in
            for _ in 0...1000 {
                let student = Student(attributes: jsonAttributes)
                XCTAssertNotNil(student)
            }
            ModelManager.sharedManager.saveContext()
        }
    }
    
}