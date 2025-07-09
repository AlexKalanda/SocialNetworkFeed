//
//  CoreManager.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import Foundation
import CoreData

class CoreManager {
    static let shared = CoreManager()
    var posts: [PostEntity] = []
    var likedPosts: Set<PostLike> = []
    
    private init() {
        fetchPostLike()
        fetchAll()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SocialNetworkFeed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Save
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Проверяем этот ли пост
    func isPost(_ postId: Int) -> Bool {
        return posts.contains { $0.id == Int32(postId) }
    }
    
    // MARK: добавить или удалить
    func addOrRemove(postData: PostData) {
        if isPost(postData.id) {
            removePost(postId: postData.id)
        } else {
            addPost(postData: postData)
        }
    }
        
    // MARK: Fetch
    func fetchAll() {
        let requst = PostEntity.fetchRequest()
        if let posts = try? persistentContainer.viewContext.fetch(requst) {
            self.posts = posts
        }
    }
    
    // MARK: FetchAllLikesPost
    func fetchPostLike() {
        let req = PostLike.fetchRequest()
        if let postsLike = try? persistentContainer.viewContext.fetch(req) {
            self.likedPosts = Set(postsLike)
        }
    }
    
    // MARK: Add
    func addPost(postData: PostData) {
        let post = PostEntity(context: persistentContainer.viewContext)
        post.id = Int32(postData.id)
        post.postText = postData.post.body
        post.isLiked = postData.isLiked
        post.postTitile = postData.post.title
        post.userEmail = postData.author.email
        post.userName = postData.author.username
        
        saveContext()
        fetchAll()
    }
    
    // MARK: Delete
    func removePost(postId: Int) {
        if let post = posts.first(where: { $0.id == Int32(postId) }) {
            persistentContainer.viewContext.delete(post)
            saveContext()
            fetchAll()
        }
    }
    
    // MARK: Add Like
    func addPostLile(postId: Int) {
        let postLike = PostLike(context: persistentContainer.viewContext)
        postLike.uid = Int32(postId)
        saveContext()
        fetchPostLike()
    }
    
    // MARK: Delete Like
    func removePostLile(postId: Int) {
        if let post = likedPosts.first(where: { $0.uid == Int32(postId) }) {
            persistentContainer.viewContext.delete(post)
            saveContext()
            fetchAll()
        }
    }
    
    // MARK: - Для теста
    // удалить все
    func deleteAllPosts() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            posts.removeAll()
            print("Все данные успешно удалены из CoreData")
        } catch {
            print("Ошибка при удалении данных: \(error.localizedDescription)")
            context.rollback()
        }
    }
    // удалить все лайки
    func deleteAllPostslikes() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostLike.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            likedPosts.removeAll() // Очищаем локальный кэш
            print("Все данные успешно удалены из CoreData")
        } catch {
            print("Ошибка при удалении данных: \(error.localizedDescription)")
            context.rollback()
        }
    }
    
}
