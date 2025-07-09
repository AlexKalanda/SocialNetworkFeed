//
//  ProfileVC.swift
//  SocialNetworkFeed
//
//  Created by admin on 9/7/2025.
//

import UIKit

class ProfileVC: UIViewController {
        
    lazy var mainView = ProfileView(user: self.user)
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
    }

}
