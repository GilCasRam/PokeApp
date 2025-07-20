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

        let entity = PokemonEntity(id: dto.id, name: dto.name)
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