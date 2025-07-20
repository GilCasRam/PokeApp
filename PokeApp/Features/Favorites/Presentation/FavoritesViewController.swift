import UIKit

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
        loadFavorites() // actualizar al volver
    }

    private func setupUI() {
        title = "Favoritos"
        view.backgroundColor = .systemBackground

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
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.identifier)

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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