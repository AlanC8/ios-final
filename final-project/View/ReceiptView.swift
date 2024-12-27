//
//  ReceiptView.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

protocol ReceiptViewDelegate: AnyObject {
    func didSelectReceipt(_ receipt: Receipt)
}

class ReceiptView: UIView {
    weak var delegate: ReceiptViewDelegate?
    private var receipts: [Receipt] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let size = (UIScreen.main.bounds.width - 48) / 2
        layout.itemSize = CGSize(width: size, height: size + 60)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ReceiptCollectionViewCell.self, forCellWithReuseIdentifier: ReceiptCollectionViewCell.identifier)
        return collectionView
    }()
    
    func setRefreshControl(_ refreshControl: UIRefreshControl) {
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateReceipts(_ newReceipts: [Receipt]) {
        receipts = newReceipts
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ReceiptView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receipts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceiptCollectionViewCell.identifier, for: indexPath) as? ReceiptCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: receipts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let receipt = receipts[indexPath.item]
        delegate?.didSelectReceipt(receipt)
    }
}
