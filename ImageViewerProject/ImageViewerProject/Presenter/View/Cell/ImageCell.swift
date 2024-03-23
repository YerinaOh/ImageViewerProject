//
//  ImageCell.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import SwiftUI
import Combine

struct ImageCell: View {
    @StateObject private var imageLoader = ImageLoader()
    var image: PhotoInfo
    
    var body: some View {
        NavigationLink(destination: DetailView(image: image)) {
            VStack(alignment: .leading) {
                Image(uiImage: imageLoader.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
                
                Text(image.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }.onAppear {
                imageLoader.loadImage(fromURL: image.download_url)
            }
        }
    }
}
