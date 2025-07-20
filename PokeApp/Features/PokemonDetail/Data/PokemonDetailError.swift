//
//  PokemonDetailError.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//


enum PokemonDetailError: Error {
    case invalidURL
    case generic
    case nilDTO
    case invalidId
    case emptyName
}