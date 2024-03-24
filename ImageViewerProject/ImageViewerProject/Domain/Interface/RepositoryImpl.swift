//
//  RepositoryImpl.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import Combine

/// repository의 의존성 분리를 위한 implementation repository
protocol RepositoryImpl {
    // Image Load API
    static func fetchData(page: Int) -> AnyPublisher<[PhotoInfo], NetworkError>
}
