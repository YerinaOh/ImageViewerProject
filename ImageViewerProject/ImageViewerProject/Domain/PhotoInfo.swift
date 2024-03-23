//
//  PhotoInfo.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation

struct PhotoInfo: Codable {
    var id: String = ""
    var author: String = "No name"
    var download_url: String = ""
    
    func getImageURL(isFullSize: Bool = false) -> String {
        if isFullSize {
            return download_url
        } else {
            return "https://picsum.photos/id/\(id)/100/100"
        }
    }
}
