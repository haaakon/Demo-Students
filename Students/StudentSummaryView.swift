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
    func numberOfStudentsInStudentSummaryView(studentSummaryView: StudentSummaryView) -> Int
}

class StudentSummaryView: UIView {
    
    @IBOutlet weak var numberOfStudentsLabel : UILabel!
    
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
        
    }
    
}
