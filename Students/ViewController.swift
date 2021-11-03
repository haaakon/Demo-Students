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
    
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        scrollView.backgroundColor = .red
        print(scrollView.contentSize)
        
        scrollView.contentSize = CGSize.init(width: scrollView.frame.width, height: 1000)
        scrollView.setContentOffset(CGPoint.init(x: 100, y: 500), animated: true)
        
        let myLabel = UILabel.init(frame: CGRect.init(x: 100, y: 500, width: 200, height: 200))
        
        myLabel.backgroundColor = .yellow
        myLabel.text = "Hello world"
        scrollView.addSubview(myLabel)
        

//        let animateView = UIView.init(frame: CGRect.init(x: 150, y: 50, width: 100, height: 100))
//        animateView.backgroundColor = .red
//        view.addSubview(animateView)
//
//
//
//        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn) {
//
//            var frame = animateView.frame
//            frame.origin.y += 400
//            frame.size.width += 100
//            frame.size.height -= 100
//            animateView.frame = frame
//
//        } completion: { (completed) in
//
//            UIView.animate(withDuration: 0.5) {
//
//                animateView.alpha = 0
//
//
//            }
//        }

        
        
        studentSummaryView.dataSource = studentSummaryViewDataSource
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize.init(width: scrollView.frame.width, height: 1000)
        scrollView.setContentOffset(CGPoint.init(x: 100, y: 500), animated: true)
    }
    
    @IBAction func didTapAddStudentButton() {
        
        _ = Student.insertStudentWithName("John Doe", inManagedObjectContext: ModelManager.sharedManager.persistentContainer.viewContext)
        
        
        ModelManager.sharedManager.saveContext()
        studentSummaryView.reloadData()
        
    }
    
}

