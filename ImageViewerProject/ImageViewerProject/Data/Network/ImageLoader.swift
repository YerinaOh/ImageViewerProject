//
//  ImageLoader.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import Combine
import UIKit

/// Server Util: image를 request하고 image 변화를 cell에 binding 하기 위한 observedObject
final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage = UIImage(named: "placeholder")!
    private var cancellable: AnyCancellable?
    
    /// image url load function
    /// - Parameter fromURL: image download image
    func loadImage(fromURL: String) {
        
        guard let url = URL(string: fromURL) else {
            return
        }
        
        if let cachedImage = ImageCacheManager.shared.cache.object(forKey: fromURL as NSString) {
            image = cachedImage
            return
        }
        
        // 기존의 로딩 작업 취소
        cancellable?.cancel()
        
        // URLSession을 사용하여 URL에서 이미지를 비동기적으로 로드
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedImage in
                if let image = loadedImage {
                    ImageCacheManager.shared.cache.setObject(image, forKey: fromURL as NSString)
                    self?.image = image
                }
            }
    }
}
