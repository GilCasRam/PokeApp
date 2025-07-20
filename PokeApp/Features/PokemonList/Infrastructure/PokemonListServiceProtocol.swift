import Foundation

protocol PokemonListServiceProtocol {
    func fetchPokemonList(limit: Int) async throws -> [PokemonSummary]
}

final class PokemonListService: PokemonListServiceProtocol {
    
    func fetchPokemonList(limit: Int) async throws -> [PokemonSummary] {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let result = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return result.results.enumerated().map { index, item in
            // PokeAPI doesn't return ID, so we extract it from the URL
            let id = Int(item.url
                .split(separator: "/")
                .last(where: { !$0.isEmpty }) ?? "0") ?? index + 1

            return PokemonSummary(id: id, name: item.name.capitalized, url: item.url)
        }
    }
}

private struct PokemonListResponse: Decodable {
    let results: [PokemonListItem]
}

private struct PokemonListItem: Decodable {
    let name: String
    let url: String
}