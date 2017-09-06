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
    
    //Constants
    private var context: NSManagedObjectContext?
    private let ownerEntityName = "Owner"
    private let carEntityName = "Car"
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: Owner
    
    func getAllOwners() -> [Owner]? {
        var ownersList: [Owner]?
        guard let context = context else { return ownersList }
        
        //get by entity
        let request = NSFetchRequest<Owner>.init(entityName: ownerEntityName)
        do {
            ownersList = try context.fetch(request)
        } catch let error { print (error) }
        
        return ownersList
    }
    
    func creatOwner(name: String) -> Owner? {
        guard let context = context else { return nil}
        
        //create owner
        let newOwner = NSEntityDescription.insertNewObject(forEntityName: ownerEntityName, into: context) as! Owner
        newOwner.name = name
        
        do {
            try context.save()
        } catch let error { print(error) }
        
        return newOwner
    }
    
    func updateOwner(owner: Owner, newName: String) -> Owner? {
        guard let context = context else { return nil}
        
        owner.name = newName
        
        do {
            try context.save()
        } catch let error { print(error) }
        
        return owner
    }
    
    func removeOwner(owner: Owner) {
        guard let context = context else { return }
        
        context.delete(owner)
        
        do {
            try context.save()
        } catch let error { print(error) }
    }
    
    // MARK: Car
    
    func creatCar(name: String) -> Car? {
        guard let context = context else { return nil }
        
        let newCar = NSEntityDescription.insertNewObject(forEntityName: carEntityName, into: context) as! Car
        newCar.name = name
        
        do {
            try context.save()
        } catch let error { print(error) }
        
        return newCar
    }
    
    func getAllCars() -> [Car]? {
        var carsList: [Car]?
        guard let context = context else { return carsList }
        
        let request = NSFetchRequest<Car>.init(entityName: carEntityName)
        do {
            carsList = try context.fetch(request)
        } catch let error { print (error) }
        
        return carsList
    }
    
    func removeCar(car: Car) {
        guard let context = context else { return }
        
       let fetchRequest = NSFetchRequest<Owner>.init(entityName: ownerEntityName)
        
        //Use predicate
        //let predicate = NSPredicate.init(format: "SELF.name == %@", car.name!)
        //fetchRequest.predicate = predicate
        
        do {
            let elements = try context.fetch(fetchRequest)
            for obj in elements {
                context.delete(car)
            }
            try context.save()
        } catch let error { print(error) }
    }
    
    func updateCar(car: Car, newName: String) -> Car? {
        guard let context = context else { return nil }

        
        car.name = newName
        
        do {
            try context.save()
        } catch let error { print(error) }
        
        return car
    }
}
