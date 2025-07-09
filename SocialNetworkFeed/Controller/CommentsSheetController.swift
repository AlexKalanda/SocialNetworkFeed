//
//  CommentsSheetControllerViewController.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import UIKit

final class CommentSheetVC: UIViewController {
    
    private let mainView = CommentSheetView()
    private let comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setDelegateAndDataSource()
    }
    // MARK: Метод настройки (delegate,dataSource)
    private func setDelegateAndDataSource() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
}

extension CommentSheetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseId, for: indexPath) as! CommentCell
        cell.configure(with: comments[indexPath.row])
        return cell
    }
}
