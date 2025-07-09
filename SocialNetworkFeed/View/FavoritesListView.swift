//
//  FavoritesView.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import UIKit

final class FavoritesListView: NewsFeedListView {
    
    override init() {
        super.init()
        registerCells(for: self.collectionView)
    }
    override func registerCells(for collectionView: UICollectionView) {
        collectionView.register(FavoritPostCell.self, forCellWithReuseIdentifier: FavoritPostCell.reuseId)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
