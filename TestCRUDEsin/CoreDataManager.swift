//
//  CoreDataManager.swift
//  TestCRUDEsin
//
//  Created by Кирилл on 06.09.17.
//  Copyright © 2017 Kirill Esin brahopru@gmail.com. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private var context: NSManagedObjectContext?
    private let ownerEntityName = "Owner"
    private let carEntityName = "Car"
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: Owner
    
    func getAllOwners() -> [Owner]? {
        var ordersList: [Owner]?
        guard let context = context else { return ordersList }
        
        let request = NSFetchRequest<Owner>.init(entityName: ownerEntityName)
        do {
            ordersList = try context.fetch(request)
        } catch let error { print (error) }
        
        return ordersList
    }
    
    func creatOwner(name: String) -> Bool {
        guard let context = context else { return false}
        
        var result = false
        
        let newOwner = NSEntityDescription.insertNewObject(forEntityName: ownerEntityName, into: context) as! Owner
        newOwner.name = name
        
        do {
            try context.save()
            result = true
        } catch let error { print(error) }
        
        return result
    }
    
    func updateOwner(owner: Owner, newName: String) -> Bool {
        guard let context = context else { return false}
        
        var result = false
        
        owner.name = newName
        
        do {
            try context.save()
            result = true
        } catch let error { print(error) }
        
        return result
    }
    
    func removeOwner(owner: Owner) -> Bool {
        guard let context = context else { return false }
        var result = false
        
        context.delete(owner)
        
        do {
            try context.save()
            result = true
        } catch let error { print(error) }
        
        return result
    }
    
}
