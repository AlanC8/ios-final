//
//  HomeViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    private var receiptView: ReceiptView!
    private let receiptAPI = ReceiptAPI()
    private var allReceipts: [Receipt] = []
    private var filteredReceipts: [Receipt] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()
    private let authService = UserAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if authService.isLoggedIn() {
            redirectToLogin()
            return
        }
        
        setupViews()
        setupSearchController()
        setupActivityIndicator()
        setupRefreshControl()
        fetchReceiptData()
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        receiptView.setRefreshControl(refreshControl)
    }
    
    @objc private func refreshData() {
        fetchReceiptData()
    }
    
    private func setupViews() {
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Receipts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.hidesWhenStopped = true
    }
    
    private func fetchReceiptData() {
        showLoadingIndicator()
        
        let url = "https://reciepts-back-production.up.railway.app/reciepts"
        receiptAPI.fetchReceipts(from: url) { [weak self] receipts, error in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                
                if let error = error {
                    print("Ошибка при загрузке данных: \(error)")
                    return
                }
                
                if let receipts = receipts {
                    self?.allReceipts = receipts
                    self?.filteredReceipts = receipts
                    self?.receiptView.updateReceipts(receipts)
                }
            }
        }
    }
    
    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
        receiptView.isHidden = true
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        receiptView.isHidden = false
    }
    
    private func redirectToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}

extension HomeViewController: ReceiptViewDelegate {
    func didSelectReceipt(_ receipt: Receipt) {
        let detailVC = ReceiptDetailViewController(receipt: receipt)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased(), !query.isEmpty else {
            filteredReceipts = allReceipts
            receiptView.updateReceipts(allReceipts)
            return
        }
        
        filteredReceipts = allReceipts.filter { $0.title.lowercased().contains(query) }
        receiptView.updateReceipts(filteredReceipts)
    }
}
