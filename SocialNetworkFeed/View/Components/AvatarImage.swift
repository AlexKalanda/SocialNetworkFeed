//
//  AvatarImage.swift
//  SocialNetworkFeed
//
//  Created by admin on 5/7/2025.
//

import UIKit

final class AvatarImage: UIImageView {
    
    let placeholderImage = UIImage(systemName: "person.circle")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupTapGesture()
    }
    
    var onTap: (() -> Void)?
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        onTap?()
    }
    
    private func setView() {
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
    }
    
    // MARK: Загрузка Аватарки по URL
    func loadImage(urlString: String?) {
        
        guard let urlString = urlString else { return }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
