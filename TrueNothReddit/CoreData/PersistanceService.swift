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
    case trashPostEntity = "TrashedEntity"
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
    
    static func getDeletedPostCoreData()  -> [TrashedEntity]{
        let fetchRequest: NSFetchRequest<TrashedEntity> = TrashedEntity.fetchRequest()
        do {
            let trashNews = try PersistenceService.context.fetch(fetchRequest)
            return trashNews
            
        }catch{
            return []
        }
    }
    
    static func deleteAllData(_ entity: CoreDataEntities) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
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
