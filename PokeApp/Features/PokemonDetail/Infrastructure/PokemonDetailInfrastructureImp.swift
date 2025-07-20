import Foundation

final class PokemonDetailInfrastructureImp: PokemonDetailInfrastructureProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.generic)
        }
    }
}