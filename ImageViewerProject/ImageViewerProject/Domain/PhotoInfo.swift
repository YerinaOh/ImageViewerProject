//
//  PhotoInfo.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation

struct PhotoInfo: Codable {
    var photoID: String = ""
    var author: String = "No name"
    var width: Int = 0
    var height: Int = 0
    var url: String = ""
    var downloadUrl: String?
    
    // CodingKeys 열거형을 사용하여 JSON 키와 모델 프로퍼티를 매핑
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case downloadUrl = "download_url"
    }
}
