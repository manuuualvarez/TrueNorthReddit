//
//  TrashEntity.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/23/22.
//

import CoreData

extension TrashedEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrashedEntity> {
        return NSFetchRequest<TrashedEntity>(entityName: CoreDataEntities.trashPostEntity.rawValue)
    }
    
    @NSManaged public var name: String
}
