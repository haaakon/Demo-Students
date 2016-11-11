//
//  StudentSummaryView.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import UIKit

@objc

protocol StudentSummaryViewDataSource {

    func numberOfStudentsInStudentSummaryView(_ studentSummaryView: StudentSummaryView) -> Int

    func averageGradeOfStudentsInStudentSummaryView(_ studentSummaryView: StudentSummaryView) -> Float

}

class StudentSummaryView: UIView {
    
    @IBOutlet weak var numberOfStudentsLabel : UILabel!

    @IBOutlet weak var averageGradeLabel : UILabel!
    
    weak var dataSource : StudentSummaryViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    func reloadData() {
        
        if let numberOfStudents = dataSource?.numberOfStudentsInStudentSummaryView(self) {
            numberOfStudentsLabel.text = "\(numberOfStudents) studenter"
        } else {
            numberOfStudentsLabel.text = "?"
        }

        if let averageGrade = dataSource?.averageGradeOfStudentsInStudentSummaryView(self) {
            averageGradeLabel.text = "gjennomsnittskarakter: \(averageGrade)"
        } else {
            averageGradeLabel.text = "?"
        }
        
    }
    
}
