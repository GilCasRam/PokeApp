struct PokemonDetailMapper {
    
    func map(dto: PokemonDetailModel?) throws -> PokemonDetailEntity {
        guard let dto = dto else {
            throw PokemonDetailError.nilDTO
        }

        guard dto.id > 0 else {
            throw PokemonDetailError.invalidId
        }

        guard !dto.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw PokemonDetailError.emptyName
        }

        let entity = PokemonDetailEntity(
            id: dto.id,
            name: dto.name.capitalized,
            imageUrl: dto.sprites.frontDefault,
            types: dto.types.map { $0.type.name.capitalized },
            height: dto.height,
            weight: dto.weight,
            stats: dto.stats.map {
                PokemonDetailEntity.Stat(
                    name: $0.stat.name.capitalized,
                    value: $0.baseStat
                )
            },
            abilities: dto.abilities.map { $0.ability.name.capitalized }
        )

        return entity
    }
}