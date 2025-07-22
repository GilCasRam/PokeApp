//
//  SplashViewController.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import UIKit

final class SplashViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "International_Pokémon_logo.svg"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()

    private let pokeballImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pokeball-logo-png_seeklogo-286475"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        startAnimation()
    }

    private func setupLayout() {
        [logoImageView, pokeballImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            pokeballImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokeballImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            pokeballImageView.widthAnchor.constraint(equalToConstant: 120),
            pokeballImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func startAnimation() {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.autoreverse, .repeat, .allowUserInteraction],
                       animations: {
            self.pokeballImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })

        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut) {
            self.logoImageView.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.navigateToMain()
        }
    }

    private func navigateToMain() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalTransitionStyle = .crossDissolve
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true)
    }
}
