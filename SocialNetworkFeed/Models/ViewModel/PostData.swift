//
//  PostData.swift
//  SocialNetworkFeed
//
//  Created by admin on 4/7/2025.
//

import Foundation

struct PostData: Identifiable {
    let id: Int
    let post: Post
    let author: User
    let comments: [Comment]
    var likes: Int
    var isLiked: Bool
}
enum PostState {
    case big
    case small
}
