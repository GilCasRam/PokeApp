//
//  PokemonDetailMapper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonDetailMapper {
    func map(dto: PokemonDetailModel?) throws -> PokemonDetailBusinessEntity {
        guard let dto = dto else {
            throw PokemonDetailError.nilDTO
        }

        guard dto.id > 0 else {
            throw PokemonDetailError.invalidId
        }

        guard !dto.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw PokemonDetailError.emptyName
        }

        return PokemonDetailBusinessEntity(pokemon: dto)
    }
}
