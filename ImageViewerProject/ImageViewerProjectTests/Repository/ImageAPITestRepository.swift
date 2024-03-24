//
//  ImageAPITestRepository.swift
//  ImageViewerProjectTests
//
//  Created by ohyesrina on 3/24/24.
//

import Foundation
import Combine
@testable import ImageViewerProject

/// Server request test 를 위한 repository
final class ImageAPITestRepository: RepositoryImpl {
    static func fetchData(page: Int) -> AnyPublisher<[PhotoInfo], NetworkError> {
        // 테스트에 사용할 JSON 데이터 로드
        guard let jsonData = Bundle.loadJSONData(filename: "picsum_cached", type: [PhotoInfo].self) else {
            return Fail(error: NetworkError.defaultError)
                .eraseToAnyPublisher()
        }
        
        return Just(jsonData)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    static func fetchLocalData() -> [ImageViewerProject.PhotoInfo] {
        return [ImageViewerProject.PhotoInfo(id: "0", author: "Alejandro Escamilla", download_url: "https://unsplash.com/photos/yC-Yzbqy7PY"),
                ImageViewerProject.PhotoInfo(id: "1", author: "Alejandro Escamilla", download_url: "https://unsplash.com/photos/LNRyGwIJr5c"),
                ImageViewerProject.PhotoInfo(id: "2", author: "Paul Jarvis", download_url: "https://unsplash.com/photos/N7XodRrbzS0"),
                ImageViewerProject.PhotoInfo(id: "3", author: "Jerry Adney", download_url: "https://unsplash.com/photos/Dl6jeyfihLk"),
                ImageViewerProject.PhotoInfo(id: "4", author: "Go Wild", download_url: "https://unsplash.com/photos/y83Je1OC6Wc")]

    }
}
