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
    
    // API 요청을 보내는 함수
    static func fetchData(page: Int) -> AnyPublisher<[PhotoInfo], NetworkError> {
        // API 요청을 보낼 URL 설정
        let urlString = "https://picsum.photos/v2/list?page=\(page)&limit=100"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: .parsingError).eraseToAnyPublisher()
        }
        
        // URL 요청 생성
        let request = URLRequest(url: url)

        // URLSession을 사용하여 데이터 요청을 보내고 응답을 처리합니다.
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data) // 데이터 추출
            .decode(type: [PhotoInfo].self, decoder: JSONDecoder()) // JSON 디코딩
            .mapError { NetworkError.error($0.localizedDescription) }
            .eraseToAnyPublisher() // AnyPublisher로 타입 변환
    }
}
