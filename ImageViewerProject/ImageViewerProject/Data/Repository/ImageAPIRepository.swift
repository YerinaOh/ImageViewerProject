//
//  ImageAPIRepository.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import Combine

/// Server request를 위한 repository 
final class ImageAPIRepository: RepositoryImpl {
    
    // Image Load API
    static func fetchData(page: Int) -> AnyPublisher<[PhotoInfo], NetworkError> {
        // API info: https://picsum.photos
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=30"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: .pathError).eraseToAnyPublisher()
        }
        
        // URL 요청 생성
        let request = URLRequest(url: url)

        // URLSession을 사용하여 데이터 요청을 보내고 응답을 처리
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data) // 데이터 추출
            .decode(type: [PhotoInfo].self, decoder: JSONDecoder()) // JSON 디코딩
            .mapError { NetworkError.error($0.localizedDescription) }
            .eraseToAnyPublisher() // AnyPublisher로 타입 변환
    }
}
