//
//  ImageCache.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import UIKit

final class ImageCache {
    // MARK: - Singleton Instance
    static let shared = ImageCache()
    
    // MARK: - Private Properties
    private let cache = NSCache<NSString, UIImage>()
    
    func addImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func removeImage(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    private init() {}
}
