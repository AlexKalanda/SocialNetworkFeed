//
//  FavoritesController.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import UIKit

final class FavoritesListVC: UIViewController {
    let mainView = FavoritesListView()
    private let sizingCell = FavoritPostCell()
    private let coreManager = CoreManager.shared
    
    private var viewModels: [PostEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Закладки"
        view = mainView
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getdata()
    }
    
    func getdata() {
        viewModels = coreManager.posts
        mainView.collectionView.reloadData()
    }
    private func createContextMenu(for postData: PostEntity) -> UIMenu {
        let isSaved = coreManager.isPost(Int(postData.id))
        
        let bookmarkAction = UIAction(
            title: isSaved ? "Убрать из закладок" : "Добавить в закладки",
            image: UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark")
        ) { [weak self] _ in
            self?.coreManager.removePost(postId: Int(postData.id))
            self?.viewModels = self?.coreManager.posts ?? []
            self?.mainView.collectionView.reloadData()
            
        }
        
        return UIMenu(title: "", children: [bookmarkAction])
    }
    
}
extension FavoritesListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritPostCell.reuseId, for: indexPath) as! FavoritPostCell
        cell.configure(with: viewModels[indexPath.item])
        cell.menuButton.menu = createContextMenu(for: viewModels[indexPath.item])
        return cell
    }
}


extension FavoritesListVC: UICollectionViewDelegate {
    
}


extension FavoritesListVC: UICollectionViewDelegateFlowLayout {
    //    //MARK: Динамический размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sizingCell.systemLayoutSizeFitting(CGSize(width: view.frame.width - 30, height: 0), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return size
    }
    //MARK: Анимированность динамическрй ячейки
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
}
