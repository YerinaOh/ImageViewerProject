//
//  RepositoryImpl.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import Combine

protocol RepositoryImpl {
    static func fetchData(page: Int) -> AnyPublisher<[PhotoInfo], NetworkError>
}
