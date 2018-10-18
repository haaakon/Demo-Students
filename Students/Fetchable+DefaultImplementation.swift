//
//  Fetchable+DefaultImplementation.swift
//  Students
//
//  Created by Håkon Bogen on 09/11/15.
//  Copyright © 2015 haaakon. All rights reserved.
//

import UIKit
import CoreData

extension Fetchable where Self : NSManagedObject {
    
    static func allObjects(inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [Self] {
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        } catch {
            print("An error occurred")
            return [Self]()
        }
    }
}
