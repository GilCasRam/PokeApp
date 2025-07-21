//
//  PokemonSummary.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable {
    let name: String
    let url: String
}

struct PokemonModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let url: String
}
