//
//  CommentSheetView.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import UIKit

final class CommentSheetView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    // MARK: Настройка view
    private func setViews() {
        addSubview(tableView)
        tableView.backgroundColor = .systemBackground
    }
    // MARK: Настройка констрейтов
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
