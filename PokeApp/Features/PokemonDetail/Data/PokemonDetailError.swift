enum PokemonDetailError: Error {
    case invalidURL
    case generic
    case nilDTO
    case invalidId
    case emptyName
}