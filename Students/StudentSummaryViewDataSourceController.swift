//
//  StudentSummaryViewDataSourceController.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import UIKit

class StudentSummaryViewDataSourceController : StudentSummaryViewDataSource {
    
    @objc func numberOfStudentsInStudentSummaryView(_ studentSummaryView: StudentSummaryView) -> Int {
        
        let allStudents = Student.allObjects(inManagedObjectContext: ModelManager.sharedManager.persistentContainer.viewContext)
        
        return allStudents.count
        
    }

    @objc func averageGradeOfStudentsInStudentSummaryView(_ studentSummaryView: StudentSummaryView) -> Float {

        return Student.averageGrade()
    }
    
}
