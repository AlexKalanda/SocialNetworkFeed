//
//  NewsView.swift
//  SocialNetworkFeed
//
//  Created by admin on 4/7/2025.
//

import UIKit

class NewsFeedListView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        $0.allowsMultipleSelection = true
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemBackground
        return $0
    }(UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
    
    init() {
        super.init(frame: .zero)
        setConstraints()
        registerCells(for: self.collectionView)
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseId)
    }
    
    // MARK: Настройка констрейтов
    private func setConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
