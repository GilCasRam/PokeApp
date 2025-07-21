//
//  FavoritesViewController.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import UIKit
import SwiftUI

final class FavoritesViewController: UIViewController {
    
    private var favorites: [PokemonBusinessEntity] = []
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func setupUI() {
        title = "Favoritos"
        
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
        collectionView.backgroundColor = UIColor(Color.red.opacity(0.5))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.identifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let leftBarButton = UIBarButtonItem(title: "Desencriptar", style: .plain, target: self, action: #selector(didTapLeftBarButton))
        navigationItem.rightBarButtonItem = leftBarButton
    }
    
    @objc private func didTapLeftBarButton() {
        let saved = PokemonFavoritesManager.shared.getAll()
        self.favorites = saved.map {
            let decryptedName = CryptoHelper.decrypt($0.name ?? "").capitalized
            let decryptedImageUrl = CryptoHelper.decrypt($0.imageUrl ?? "")
            return PokemonBusinessEntity(pokemon: PokemonModel(
                id: Int($0.id),
                name: decryptedName,
                url: decryptedImageUrl
            ))
        }
        collectionView.reloadData()
    }
    
    private func loadFavorites() {
        let saved = PokemonFavoritesManager.shared.getAll()
        favorites = saved.map {
            PokemonBusinessEntity(
                pokemon: PokemonModel(id: Int($0.id), name: $0.name ?? "", url: "")
            )
        }
        collectionView.reloadData()
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonListCell.identifier,
            for: indexPath) as? PokemonListCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: favorites[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = favorites[indexPath.item]
        let detailViewModel = PokemonDetailViewModel()
        detailViewModel.loadDetail(id: selected.id)
        
        let detailView = PokemonDetailView(
            viewModel: detailViewModel,
            onStatsTap: { [weak self] in
                guard let self = self else { return }
                let statsViewModel = PokemonStatsViewModel(pokemon: detailViewModel.entity)
                let statsView = PokemonStatsView(viewModel: statsViewModel)
                let statsController = UIHostingController(rootView: statsView)
                statsController.view.backgroundColor = UIColor(named: "red_background")
                self.navigationController?.pushViewController(statsController, animated: true)
            }
        )
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.view.backgroundColor = UIColor(named: "red_background")
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
