//
//  DetailView.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import SwiftUI

// Mission: Image + model Info 기반 UI
struct DetailView: View {
    @StateObject private var imageLoader = ImageLoader()
    var image: PhotoInfo
    
    var body: some View {
        VStack {
            Image(uiImage: imageLoader.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding()
            Text(image.author)
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }.onAppear {
            imageLoader.loadImage(fromURL: image.getImageURL(isFullSize: true))
        }
    }
}
