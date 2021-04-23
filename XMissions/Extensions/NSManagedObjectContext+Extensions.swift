//
//  NSManagedObjectContext+Extensions.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
