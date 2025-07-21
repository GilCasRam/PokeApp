//
//  PokemonMapper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonMapper {
    
    func map(dto: PokemonModel?) throws -> PokemonBusinessEntity {
        guard let dto = dto else {
            throw PokemonError.nilDTO
        }

        guard dto.id > 0 else {
            throw PokemonError.invalidId
        }

        guard !dto.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw PokemonError.emptyName
        }

        let entity = PokemonModel(id: dto.id, name: dto.name, url: dto.url)
        return PokemonBusinessEntity(pokemon: entity)
    }

    func map(dtoList: [PokemonModel]) throws -> [PokemonBusinessEntity] {
        return try dtoList.map { try map(dto: $0) }
    }
}

enum PokemonError: Error {
    case invalidURL
    case generic
    case nilDTO
    case invalidId
    case emptyName
}

extension PokemonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida. No se pudo procesar la solicitud."
        case .generic:
            return "Algo salió mal. Intenta de nuevo más tarde."
        case .nilDTO:
            return "No se pudo obtener la información del Pokémon."
        case .invalidId:
            return "El ID del Pokémon no es válido."
        case .emptyName:
            return "El nombre del Pokémon está vacío o incompleto."
        }
    }
}
