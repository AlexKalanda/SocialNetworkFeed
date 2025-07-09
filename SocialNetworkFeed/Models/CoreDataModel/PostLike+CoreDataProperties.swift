//
//  PostLike+CoreDataProperties.swift
//  SocialNetworkFeed
//
//  Created by admin on 8/7/2025.
//
//

import Foundation
import CoreData


extension PostLike {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostLike> {
        return NSFetchRequest<PostLike>(entityName: "PostLike")
    }

    @NSManaged public var uid: Int32

}

extension PostLike : Identifiable {

}
