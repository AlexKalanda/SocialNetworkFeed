//
//  NewsController.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import UIKit

final class NewsFeedListVC: UIViewController {
    
    lazy var mainView = NewsFeedListView()
    private let netwokService = NetworkService.shared
    private let refreshControl = UIRefreshControl()
    
    private var userCache: [Int: User] = [:]
    private var posts: [Post] = []
    private var allComments: [Comment] = []
    
    private var viewModels: [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Лента"
        view = mainView
        setDelegateAndDataSource()
        setRefreshControl()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    
    // MARK: Метод настройки (delegate,dataSource)
    private func setDelegateAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    // MARK: Метод настройки RefreshControl
    private func setRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .systemBlue
        mainView.collectionView.refreshControl = refreshControl
    }
    // MARK: Получение данных
    private func getData(completion: (() -> Void)? = nil) {
        let group = DispatchGroup()
        var lastError: Error?
        
        group.enter()
        getUsers {
            lastError = $0
            group.leave()
        }
        
        group.enter()
        getPosts {
            lastError = $0
            group.leave()
        }
        
        group.enter()
        getComments {
            lastError = $0
            group.leave()
        }
        
        group.notify(queue: .global(qos: .userInitiated)) {
            if let error = lastError {
                print("Ошибка загрузки: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion?()
                }
                return
            }
            self.createViewModels()
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    // MARK: Получение данных Users
    private func getUsers(completion: @escaping (Error?) -> Void) {
        NetworkService.shared.fetchData(endpoint: .users) { [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                self?.userCache = Dictionary(uniqueKeysWithValues: users.map { ($0.id, $0) })
            case .failure(let error):
                completion(error)
                return
            }
            completion(nil)
        }
    }
    // MARK: Получение Posts
    private func getPosts(completion: @escaping (Error?) -> Void) {
        NetworkService.shared.fetchData(endpoint: .posts) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                completion(error)
                return
            }
            completion(nil)
        }
    }
    // MARK: Получение Comment
    private func getComments(completion: @escaping (Error?) -> Void) {
        NetworkService.shared.fetchData(endpoint: .comments) { [weak self] (result: Result<[Comment], Error>) in
            switch result {
            case .success(let comments):
                self?.allComments = comments
            case .failure(let error):
                completion(error)
                return
            }
            completion(nil)
        }
    }
    // MARK: Создание модели для View
    private func createViewModels() {
        // Группируем комментарии по postId
        let commentsDict = Dictionary(grouping: allComments, by: { $0.postId })
        
        viewModels = posts.compactMap { post in
            guard let author = userCache[post.userId] else { return nil }
            
            let isLiked = CoreManager.shared.likedPosts.contains { $0.uid == Int32(post.id) }
            
            return PostData(
                id: post.id,
                post: post,
                author: author,
                comments: commentsDict[post.id] ?? [],
                likes: Int.random(in: 0...10_000),
                isLiked: isLiked
            )
        }
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
        }
        
    }
    // MARK: Метод для показа комментариев
    private func showComments(for postData: PostData) {
        let commentController = CommentSheetVC(comments: postData.comments)
        let navController = UINavigationController(rootViewController: commentController)
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navController, animated: true)
    }
    // MARK: Pull-to-refresh
    @objc
    private func handleRefresh() {
        userCache.removeAll()
        posts.removeAll()
        allComments.removeAll()
        viewModels.removeAll()
        mainView.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Для увеличения задержки (что бы наглядно было)
            self.getData { [weak self] in
                self?.refreshControl.endRefreshing()
            }
        }
        
    }
    // MARK: Настройка контекстного меню
    private func createContextMenu(for postData: PostData) -> UIMenu {
        let isSaved = CoreManager.shared.isPost(postData.id)
        
        let bookmarkAction = UIAction(
            title: isSaved ? "Убрать из закладок" : "Добавить в закладки",
            image: UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark")
        ) { [weak self] _ in
            self?.addOrRemove(for: postData)
        }
        
        let share = UIAction(
            title: "Поделиться",
            image: UIImage(systemName: "square.and.arrow.up")
        ) {  _ in
            print("Поделиться")
        }
        
        return UIMenu(title: "", children: [bookmarkAction, share])
    }
    // MARK: Добавить/удалить в закладки
    private func addOrRemove(for postData: PostData) {
        CoreManager.shared.addOrRemove(postData: postData)
        if let index = viewModels.firstIndex(where: { $0.id == postData.id }) {
            let indexPath = IndexPath(item: index, section: 0)
            mainView.collectionView.reloadItems(at: [indexPath])
        }
    }
    // MARK: Поставить/убрать лайк
    private func toggleLike(for postData: PostData) {
        if postData.isLiked {
            CoreManager.shared.removePostLile(postId: postData.id)
        } else {
            CoreManager.shared.addPostLile(postId: postData.id)
        }
        if let index = viewModels.firstIndex(where: { $0.id == postData.id }) {
            viewModels[index].isLiked.toggle()
        }
    }

}

extension NewsFeedListVC: UICollectionViewDataSource {
    //MARK: Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    //MARK: Внешний вид ячейки и обрабока действий по эллементам ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseId, for: indexPath) as! PostCell
        cell.configure(with: viewModels[indexPath.item])
        cell.menuButton.menu = createContextMenu(for: viewModels[indexPath.item])
        // тап по лайку
        cell.onCommentsTapped = { [weak self] in
            if let viewModel = self?.viewModels[indexPath.item] {
                self?.showComments(for: viewModel)
            }
        }
        // тап по лайку
        cell.onLikeTapped = { [weak self] in
            if let viewModel = self?.viewModels[indexPath.item] {
                cell.isliked?.toggle()
                self?.toggleLike(for: viewModel)
            }
        }
        // тап по аватарки
        cell.onAvatarTapped = { [weak self] in
            if let viewModel = self?.viewModels[indexPath.item] {
                let user = viewModel.author
                let vc = ProfileVC()
                vc.user = user
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
}

extension NewsFeedListVC: UICollectionViewDelegate { }

