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
    var width: Int = 0
    var height: Int = 0
    var url: String = ""
    var download_url: String = ""
}
