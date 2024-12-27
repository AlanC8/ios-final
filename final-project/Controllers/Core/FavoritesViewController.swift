//
//  FavoritesViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//
import UIKit

class FavoritesViewController: UIViewController {
    private var receiptView: ReceiptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func setupViews() {
        title = "Favorites"
        receiptView = ReceiptView(frame: view.bounds)
        receiptView.delegate = self
        view.addSubview(receiptView)
        
        receiptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receiptView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            receiptView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            receiptView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            receiptView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadFavorites() {
        let favorites = FavoritesManager.shared.getFavorites()
        receiptView.updateReceipts(favorites)
    }
}

extension FavoritesViewController: ReceiptViewDelegate {
    func didSelectReceipt(_ receipt: Receipt) {
        let detailVC = ReceiptDetailViewController(receipt: receipt)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
