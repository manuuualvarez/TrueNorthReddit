//
//  PersistanceService.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/23/22.
//

import Foundation
import CoreData


enum CoreDataEntities: String {
    case postReadEntity = "PostReadEntity"
    case trashPostEntity = "TrashedPostEntity"
}


class PersistenceService {
    
    private init(){}
    static var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    static func getReadedPostCoreData()  -> [PostReadEntity]{
        let fetchRequest: NSFetchRequest<PostReadEntity> = PostReadEntity.fetchRequest()
        do {
            let localPost = try PersistenceService.context.fetch(fetchRequest)
            return localPost
            
        }catch{
            return []
        }
    }
    

    
// MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
// MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
