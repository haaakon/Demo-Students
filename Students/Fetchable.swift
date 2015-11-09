//
//  Fetchable.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import UIKit
import CoreData

protocol Fetchable {
    
    static var entityName : String { get }
    
    static func allObjects(inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [Self]
    
}
