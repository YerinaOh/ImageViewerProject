//
//  ImageCacheManager.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/24/24.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    var cache = NSCache<NSString, UIImage>()

    subscript(_ key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSString) : cache.setObject(newValue!, forKey: key as NSString) }
    }
}
