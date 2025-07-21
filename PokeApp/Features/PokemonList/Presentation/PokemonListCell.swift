//
//  PokemonListCell.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import UIKit

final class PokemonListCell: UICollectionViewCell {
    static let identifier = "PokemonListCell"

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let favoriteIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with pokemon: PokemonBusinessEntity) {
        nameLabel.text = pokemon.name
        imageView.image = nil

        if let url = URL(string: pokemon.imageUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data,
                      let image = UIImage(data: data) else { return }

                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }.resume()
        }
        favoriteIcon.isHidden = !PokemonFavoritesManager.shared.isFavorite(id: pokemon.id)
    }

    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 14)

        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.image = UIImage(systemName: "heart.fill")
        favoriteIcon.tintColor = .red
        favoriteIcon.isHidden = true
        contentView.addSubview(favoriteIcon)

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            favoriteIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            favoriteIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 16),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 16),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        contentView.backgroundColor = UIColor(named: "PrimaryYellow")
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
}
