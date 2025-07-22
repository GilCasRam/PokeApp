//
//  PokemonDetailMapper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

/// Responsible for converting a `PokemonDetailModel` (data layer) into a `PokemonDetailBusinessEntity` (domain layer).
/// Performs validation to ensure the DTO contains valid data before mapping.
struct PokemonDetailMapper {
    /// Maps a DTO (Data Transfer Object) into a domain/business entity.
    /// - Parameter dto: The model received from the API or data source.
    /// - Throws: `PokemonDetailError` if the DTO is missing or contains invalid data.
    /// - Returns: A valid `PokemonDetailBusinessEntity` ready to be used in the domain or presentation layer.
    func map(dto: PokemonDetailModel?) throws -> PokemonDetailBusinessEntity {
        // Checks if the DTO is nil. If it is, throws a custom error.
        guard let dto = dto else {
            throw PokemonDetailError.nilDTO
        }

        // Validates the ID to make sure it's a positive number.
        guard dto.id > 0 else {
            throw PokemonDetailError.invalidId
        }

        // Ensures the name is not empty or made up of only whitespace.
        guard !dto.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw PokemonDetailError.emptyName
        }

        // Returns the domain/business entity, wrapping the validated DTO.
        return PokemonDetailBusinessEntity(pokemon: dto)
    }
}
