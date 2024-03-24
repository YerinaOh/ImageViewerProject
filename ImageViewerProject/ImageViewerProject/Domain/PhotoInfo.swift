//
//  PhotoInfo.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation

/// image model data
struct PhotoInfo: Codable {
    var id: String = "" // photoid
    var author: String = "No name" // 이미지 저자
    var download_url: String = "" // 다운로드 url
    
    /// image url 경로
    /// - Parameter isFullSize: 메모리 절약을 위해 list 는 thumbnail용 사이즈를 return 하기위함.
    /// - Returns: 이미지 경로
    public func getImageURL(isFullSize: Bool = false) -> String {
        if isFullSize {
            return download_url
        } else {
            return "https://picsum.photos/id/\(id)/100/100"
        }
    }
}
