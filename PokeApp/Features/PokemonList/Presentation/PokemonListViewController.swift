import UIKit

final class PokemonListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = PokemonListViewModel()
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPokemons()
    }

    // MARK: - UI Setup
    private func setupUI() {
        title = "Pokémon List"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)

        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] in
            guard let self = self else { return }

            if self.viewModel.isLoading {
                self.loadingIndicator.startAnimating()
                self.tableView.isHidden = true
                self.errorLabel.isHidden = true
            } else {
                self.loadingIndicator.stopAnimating()
                self.tableView.isHidden = self.viewModel.pokemons.isEmpty
                self.errorLabel.isHidden = self.viewModel.errorMessage == nil
                self.errorLabel.text = self.viewModel.errorMessage
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.textLabel?.text = "#\(pokemon.id) \(pokemon.name)"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedPokemon = viewModel.pokemons[indexPath.row]

        // Aquí más adelante navegaremos al Detail usando UIKit → SwiftUI
        print("Selected Pokémon: \(selectedPokemon.name)")
    }
}