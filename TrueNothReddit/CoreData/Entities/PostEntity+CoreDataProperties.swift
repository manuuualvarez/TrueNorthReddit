//
//  PostEntity+CoreDataProperties.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/23/22.
//

import Foundation
import CoreData

extension PostReadEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostReadEntity> {
        return NSFetchRequest<PostReadEntity>(entityName: CoreDataEntities.postReadEntity.rawValue)
    }
    
    @NSManaged public var name: String

    
}
