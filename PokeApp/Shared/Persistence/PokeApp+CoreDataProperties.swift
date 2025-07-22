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

    /// Generates a fetch request for the `PokeApp` entity in Core Data.
    /// This allows querying the local database for saved favorite Pokémon.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokeApp> {
        return NSFetchRequest<PokeApp>(entityName: "PokeApp")
    }

    /// The unique identifier of the Pokémon, stored as a 64-bit integer.
    /// Core Data typically stores numeric values using `Int64` for compatibility.
    @NSManaged public var id: Int64

    /// The name of the Pokémon.
    /// Optional because Core Data allows the field to be nil unless constrained.
    @NSManaged public var name: String?

    /// The image URL of the Pokémon, used to display the sprite or illustration.
    /// Also optional in case some entries don't have a saved image.
    @NSManaged public var imageUrl: String?

}

extension PokeApp: Identifiable {

}
