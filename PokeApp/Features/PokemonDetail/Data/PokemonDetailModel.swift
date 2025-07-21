//
//  PokemonDetailModel.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonDetailModel: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [PokemonStat]
    let abilities: [PokemonAbilitySlot]
}

struct Sprites: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonTypeSlot: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

struct PokemonStat: Decodable {
    let baseStat: Int
    let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PokemonAbilitySlot: Decodable {
    let ability: NamedAPIResource
    let isHidden: Bool

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
    }
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}
