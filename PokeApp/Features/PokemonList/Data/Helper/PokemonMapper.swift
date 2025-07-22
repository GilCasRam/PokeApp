//
//  PokemonMapper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonMapper {
    /// Maps a `PokemonModel` (DTO) into a `PokemonBusinessEntity`.
    /// Validates the input data before converting it to a domain-safe entity.
    /// - Parameter dto: The data transfer object received from the API or cache.
    /// - Throws: A `PokemonError` if the data is invalid or missing.
    /// - Returns: A business entity used in the domain or presentation layers.
    func map(dto: PokemonModel?) throws -> PokemonBusinessEntity {
        // Validates that the DTO exists.
        guard let dto = dto else {
            throw PokemonError.nilDTO
        }

        // Ensures the ID is a valid positive number.
        guard dto.id > 0 else {
            throw PokemonError.invalidId
        }

        // Checks that the name is not empty or whitespace-only.
        guard !dto.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw PokemonError.emptyName
        }

        // Wraps the validated DTO in a business entity.
        let entity = PokemonModel(id: dto.id, name: dto.name, url: dto.url)
        return PokemonBusinessEntity(pokemon: entity)
    }

    /// Maps a list of `PokemonModel` DTOs into a list of `PokemonBusinessEntity`.
    /// Validates each individual item using the single-entity mapper function.
    /// - Parameter dtoList: Array of data transfer objects received from the API.
    /// - Throws: A `PokemonError` if any item in the list is invalid.
    /// - Returns: An array of validated business entities ready for use in the domain or UI.
    func map(dtoList: [PokemonModel]) throws -> [PokemonBusinessEntity] {
        // Applies the existing `map(dto:)` function to each element.
        // If any element throws an error, the entire operation fails.
        return try dtoList.map { try map(dto: $0) }
    }
}
