//
//  FavoritPostCell.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import UIKit


class FavoritPostCell: UICollectionViewCell {
    static let reuseId = "FavoritPostCell"
    private var postBottomAnchor: NSLayoutConstraint?
    
    lazy var cellHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        view.addSubview(postTitleLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(menuButton)
        return view
    }()
    
    lazy var cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postTexLabel)
        return view
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postTexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.tintColor = .label
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()
    // Отслеживание нажатия на ячейку
    override var isSelected: Bool { didSet { updateLayoutCell() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    
    func setViews() {
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.color(light: .black.withAlphaComponent(0.3),
                                          dark: .white.withAlphaComponent(0.3)).cgColor
        contentView.addSubview(cellHeader)
        contentView.addSubview(cellContent)
    }
    
    func setConstraints() {
        postBottomAnchor = postTexLabel.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        postBottomAnchor?.priority = .defaultHigh
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            
            userNameLabel.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor, constant: 10),
            userNameLabel.topAnchor.constraint(equalTo: cellHeader.topAnchor, constant: 10),
            
            menuButton.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor, constant: -10),
            menuButton.topAnchor.constraint(equalTo: cellHeader.topAnchor,constant: 10),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            userEmailLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            postTitleLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor,constant: 10),
            postTitleLabel.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor, constant: 10),
            postTitleLabel.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor, constant: -10),
            postTitleLabel.bottomAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: -10),
            
            cellContent.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            cellContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            postTexLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 10),
            postTexLabel.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 10),
            
        ])
        
    }
    // MARK: Управление констрейтами для гибкости ячейки
    private func updateLayoutCell() {
        postBottomAnchor?.isActive = isSelected
    }
    // MARK: Прокидываем данные по ячейки
    func configure(with viewModel: PostEntity) {
        userNameLabel.text = viewModel.userName
        postTitleLabel.text = viewModel.postTitile
        postTexLabel.text = viewModel.postText
        userEmailLabel.text = "E-mail: \(viewModel.userEmail)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

