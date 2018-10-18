//
//  ViewController.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let studentSummaryViewDataSource = StudentSummaryViewDataSourceController()
    
    @IBOutlet weak var studentSummaryView : StudentSummaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentSummaryView.dataSource = studentSummaryViewDataSource
        
    }
    
    @IBAction func didTapAddStudentButton() {
        
        Student.insertStudentWithName("John Doe", inManagedObjectContext: ModelManager.sharedManager.persistentContainer.viewContext)
        ModelManager.sharedManager.saveContext()
        studentSummaryView.reloadData()
        
    }
    
}

