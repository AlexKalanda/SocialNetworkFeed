//
//  PostCell.swift
//  SocialNetworkFeed
//
//  Created by admin on 5/7/2025.
//

import UIKit

final class PostCell: UICollectionViewCell {

    static let reuseId = "PostCell"

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
        label.numberOfLines = 2
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

    lazy var avatarImage: AvatarImage = {
        let imageView = AvatarImage(frame: .zero)
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.color(light: .black, dark: .white).cgColor
        return imageView
    }()

    lazy var likesButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(likesButtonTapped), for: .touchUpInside)
        return btn
    }()

    lazy var commentsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "bubble"), for: .normal)
        btn.tintColor = UIColor.color(light: .gray, dark: .white)
        btn.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
        return btn
    }()

    lazy var countLikesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var countCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Замыкание по тапу кнопки комментраий
    var onCommentsTapped: (() -> Void)?
    // Замыкание по тапу на сердечко
    var onLikeTapped: (() -> Void)?
    // Замыкание по тапу на ававтар
    var onAvatarTapped: (() -> Void)?
    // Для моментального изменения лайка
    var isliked: Bool?  {
        didSet { updateLikeButton(isLiked: isliked ?? false) }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        setupAvatarTap()
    }
    // MARK: Настройка view
    private func setViews() {
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.color(light: .black.withAlphaComponent(0.3),
                                          dark: .white.withAlphaComponent(0.3)).cgColor
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userEmailLabel)
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postTexLabel)
        contentView.addSubview(menuButton)
        contentView.addSubview(avatarImage)
        contentView.addSubview(likesButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(countLikesLabel)
        contentView.addSubview(countCommentsLabel)
    }
    // MARK: Настройка констрейнтов
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            
            menuButton.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            userEmailLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            postTitleLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            postTexLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 10),
            postTexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postTexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            likesButton.leadingAnchor.constraint(equalTo: postTexLabel.leadingAnchor),
            likesButton.topAnchor.constraint(equalTo: postTexLabel.bottomAnchor, constant: 10),
            likesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            countLikesLabel.leadingAnchor.constraint(equalTo: likesButton.trailingAnchor, constant: 5),
            countLikesLabel.centerYAnchor.constraint(equalTo: likesButton.centerYAnchor),
            
            commentsButton.leadingAnchor.constraint(equalTo: countLikesLabel.trailingAnchor, constant: 10),
            commentsButton.topAnchor.constraint(equalTo: likesButton.topAnchor),
            
            countCommentsLabel.leadingAnchor.constraint(equalTo: commentsButton.trailingAnchor, constant: 5),
            countCommentsLabel.centerYAnchor.constraint(equalTo: likesButton.centerYAnchor),
        ])

    }
    // MARK: Прокидываем данные по ячейки
    func configure(with viewModel: PostData) {
        isliked = viewModel.isLiked
        userNameLabel.text = viewModel.author.username
        postTitleLabel.text = viewModel.post.title
        postTexLabel.text = viewModel.post.body
        countLikesLabel.text = viewModel.likes.stringValue()
        countCommentsLabel.text = viewModel.comments.count.stringValue()
        userEmailLabel.text = "E-mail: \(viewModel.author.email)"
        // Загрузка аватарки, если есть ссылка
        avatarImage.loadImage(urlString: viewModel.author.avatar)
    }
    // Обновление лайка
    private func updateLikeButton(isLiked: Bool) {
        let imageName = isLiked ? "heart.fill" : "heart"
        likesButton.setImage(UIImage(systemName: imageName), for: .normal)
        likesButton.tintColor = isLiked ? .red : .gray
    }
    // Захват тапа по аватарки
    private func setupAvatarTap() {
        avatarImage.onTap = { [weak self] in
            self?.avatarTapped()
        }
    }
    // Вызов замыкания по тапу на кнопку комментарий
    @objc private func commentsButtonTapped() {
        onCommentsTapped?()
    }
    // Вызов замыкания по тапу на сердечко
    @objc private func likesButtonTapped() {
        onLikeTapped?()
    }
    // Вызов замыкания по тапу на сердечко
    @objc private func avatarTapped() {
        onAvatarTapped?()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
