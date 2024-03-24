//
//  ImageAPI.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation

/// custom Error type
enum NetworkError: Error {
    case error(String) // custom error
    case pathError // path error
    case defaultError // 기본 error
    
    var message: String {
        switch self {
        case let .error(msg):
            return msg
        case .pathError:
            return "잘못된 URL입니다."
        case .defaultError:
            return "일시적으로 서버를 이용할 수 없습니다."
        }
    }
}
