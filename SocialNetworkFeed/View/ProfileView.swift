//
//  ProfileView.swift
//  SocialNetworkFeed
//
//  Created by admin on 9/7/2025.
//

import UIKit

final class ProfileView: UIView {
    
    var user: User
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.color(light: .white, dark: .black)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.color(light: .systemGray2, dark: .systemGray4)
        return view
    }()
    
    lazy var avatarImage: AvatarImage = {
        let imageView = AvatarImage(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.blue.cgColor
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.label
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var websitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var companyBSLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailLabel,
            phoneNumberLabel,
            adressLabel,
            websitLabel,
            companyLabel,
            companyBSLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initialization
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        configure(with: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupViews() {
        addSubview(headerView)
        addSubview(contentView)
        headerView.addSubview(avatarImage)
        headerView.addSubview(nameLabel)
        contentView.addSubview(infoStackView)
        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            avatarImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
        
    private func configure(with user: User) {
        nameLabel.text = user.username
        emailLabel.text = "Email: \(user.email)"
        phoneNumberLabel.text = "Телефон: \(user.phone)"
        websitLabel.text = "Сайт: \(user.website)"
        adressLabel.text = "Адрес: город: \(user.address.city), улица: \(user.address.street)"
        companyLabel.text = "Компания: \(user.company.name)"
        companyBSLabel.text = "Описание: \(user.company.bs)"
        
        avatarImage.loadImage(urlString: user.avatar)
    }
    
    
}
