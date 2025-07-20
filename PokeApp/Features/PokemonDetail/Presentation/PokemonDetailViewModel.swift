import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let useCase: GetPokemonDetailProtocol

    // MARK: - State
    @Published var errorMessage: String?
    @Published var entity = PokemonDetailBusinessEntity()
    @Published var isLoading: Bool = false

    // MARK: - Init
    init(useCase: GetPokemonDetailProtocol = PokemonDetailFactory.useCase()) {
        self.useCase = useCase
    }

    // MARK: - Public Methods
    func loadDetail(id: Int) {
        Task {
            isLoading = true
            let result = await useCase.execute(id: id)
            switch result {
            case .success(let detail):
                self.entity = detail
                self.errorMessage = nil
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}