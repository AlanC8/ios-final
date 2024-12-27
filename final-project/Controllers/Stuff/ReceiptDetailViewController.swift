//
//  ReceiptDetailViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class ReceiptDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    
    private let ratingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemYellow
        return label
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemYellow
        return image
    }()
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ingredientsSectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let ingredientsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let timeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()
    
    private let clockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .systemBlue
        return image
    }()
    
    private let receipt: Receipt
    
    init(receipt: Receipt) {
        self.receipt = receipt
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureWithReceipt()
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        favoriteButton.isSelected = FavoritesManager.shared.isInFavorites(receipt)
    }
    
    @objc private func favoriteButtonTapped() {
        if favoriteButton.isSelected {
            FavoritesManager.shared.removeFromFavorites(receipt)
        } else {
            FavoritesManager.shared.saveToFavorites(receipt)
        }
        favoriteButton.isSelected.toggle()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [imageView, infoContainer].forEach {
            containerView.addSubview($0)
        }
        
        [titleLabel, priceContainer, ratingContainer, timeContainer, sectionTitle,
         descriptionLabel, ingredientsSectionTitle, ingredientsStack].forEach {
            infoContainer.addSubview($0)
        }
        
        priceContainer.addSubview(priceLabel)
        ratingContainer.addSubview(ratingLabel)
        ratingContainer.addSubview(starImage)
        timeContainer.addSubview(timeLabel)
        timeContainer.addSubview(clockImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        [scrollView, containerView, imageView, infoContainer, titleLabel, priceContainer,
         priceLabel, ratingContainer, ratingLabel, starImage, timeContainer, timeLabel,
         clockImage, sectionTitle, descriptionLabel, ingredientsSectionTitle,
         ingredientsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            infoContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            infoContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            infoContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            
            priceContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            priceContainer.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            priceContainer.heightAnchor.constraint(equalToConstant: 40),
            
            priceLabel.leadingAnchor.constraint(equalTo: priceContainer.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: -16),
            priceLabel.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            
            ratingContainer.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            ratingContainer.leadingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: 12),
            ratingContainer.heightAnchor.constraint(equalToConstant: 40),
            
            starImage.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor, constant: 12),
            starImage.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 16),
            starImage.heightAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainer.trailingAnchor, constant: -12),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            
            timeContainer.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            timeContainer.leadingAnchor.constraint(equalTo: ratingContainer.trailingAnchor, constant: 12),
            timeContainer.heightAnchor.constraint(equalToConstant: 40),
            
            clockImage.leadingAnchor.constraint(equalTo: timeContainer.leadingAnchor, constant: 12),
            clockImage.centerYAnchor.constraint(equalTo: timeContainer.centerYAnchor),
            clockImage.widthAnchor.constraint(equalToConstant: 16),
            clockImage.heightAnchor.constraint(equalToConstant: 16),
            
            timeLabel.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: timeContainer.trailingAnchor, constant: -12),
            timeLabel.centerYAnchor.constraint(equalTo: timeContainer.centerYAnchor),
            
            sectionTitle.topAnchor.constraint(equalTo: priceContainer.bottomAnchor, constant: 24),
            sectionTitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            sectionTitle.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            
            ingredientsSectionTitle.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            ingredientsSectionTitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            ingredientsSectionTitle.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            
            ingredientsStack.topAnchor.constraint(equalTo: ingredientsSectionTitle.bottomAnchor, constant: 8),
            ingredientsStack.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            ingredientsStack.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            ingredientsStack.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -24)
        ])
    }
    
    private func configureWithReceipt() {
        titleLabel.text = receipt.title
        priceLabel.text = "$\(receipt.price)"
        ratingLabel.text = String(format: "%.1f", receipt.rating)
        timeLabel.text = "\(receipt.preparationTime) min"
        descriptionLabel.text = receipt.description
        
        receipt.ingredients.forEach { ingredient in
            let ingredientView = createIngredientView(with: ingredient)
            ingredientsStack.addArrangedSubview(ingredientView)
        }
        
        if let imageURL = URL(string: receipt.image[0]) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    private func createIngredientView(with ingredient: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = "• " + ingredient
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])
        
        return container
    }
}
