//
//  PokemonError.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

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
