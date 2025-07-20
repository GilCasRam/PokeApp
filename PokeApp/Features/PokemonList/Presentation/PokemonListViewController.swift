//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import UIKit
import Combine
import SwiftUI

final class PokemonListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = PokemonListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    
    private var collectionView: UICollectionView!
    private var isFetchingMore = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadPokemons()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteUpdated), name: .favoriteStatusChanged, object: nil)
    }

    // MARK: - UI Setup
    private func setupUI() {
        title = "Pokémon List"
        view.backgroundColor = UIColor(Color.red.opacity(0.5))

        // MARK: - CollectionView Layout
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let itemsPerRow: CGFloat = 3
        let itemWidth = (view.bounds.width - (itemsPerRow + 1) * spacing) / itemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: 120)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor =  .clear
//        collectionView.backgroundColor = UIColor(named: "PrimaryYellow") ?? .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.identifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        view.addSubview(collectionView)

        // MARK: - Loading Indicator
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)

        // MARK: - Error Label
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

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
        viewModel.$pokemons
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
                self?.loadingIndicator.stopAnimating()
                self?.collectionView.isHidden = false
                self?.errorLabel.isHidden = true
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                guard let self = self, let error = errorMessage else { return }
                
                self.loadingIndicator.stopAnimating()
                self.collectionView.isHidden = false
                self.errorLabel.isHidden = true

                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    self.viewModel.loadPokemons()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true)
            }
            .store(in: &cancellables)

        loadingIndicator.startAnimating()
    }
    @objc private func favoriteUpdated() {
        collectionView.reloadData()
    }
    @objc private func handleRefresh() {
        viewModel.loadPokemons()
        collectionView.refreshControl?.endRefreshing()
    }
}

extension PokemonListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonListCell.identifier,
            for: indexPath) as? PokemonListCell else {
            return UICollectionViewCell()
        }

        let pokemon = viewModel.pokemons[indexPath.item]
        cell.configure(with: pokemon)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.pokemons[indexPath.item]
        print("Selected Pokémon: \(selected.name)")
        let detailViewModel = PokemonDetailViewModel()
        detailViewModel.loadDetail(id: selected.id)

        let detailView = PokemonDetailView(
            viewModel: detailViewModel,
            onStatsTap: { [weak self] in
                guard let self = self else { return }
                let statsViewModel = PokemonStatsViewModel(pokemon: detailViewModel.entity)
                let statsView = PokemonStatsView(viewModel: statsViewModel)
                let statsController = UIHostingController(rootView: statsView)
                self.navigationController?.pushViewController(statsController, animated: true)
            }
        )
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = viewModel.pokemons.count - 1
        if indexPath.item == lastIndex && !viewModel.isLoading {
            viewModel.offset += viewModel.limit
            viewModel.loadPokemons()
        }
    }
}
