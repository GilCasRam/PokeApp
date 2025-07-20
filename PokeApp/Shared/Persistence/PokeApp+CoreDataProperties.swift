//
//  PokeApp+CoreDataProperties.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//
//

import Foundation
import CoreData


extension PokeApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokeApp> {
        return NSFetchRequest<PokeApp>(entityName: "PokeApp")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?

}

extension PokeApp : Identifiable {

}
