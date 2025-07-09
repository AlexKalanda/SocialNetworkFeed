//
//  PostEntity+CoreDataProperties.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isLiked: Bool
    @NSManaged public var userName: String
    @NSManaged public var userEmail: String
    @NSManaged public var postTitile: String
    @NSManaged public var postText: String
}

extension PostEntity : Identifiable {
    
}
