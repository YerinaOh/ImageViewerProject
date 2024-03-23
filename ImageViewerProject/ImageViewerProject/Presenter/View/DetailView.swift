//
//  DetailView.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var image: PhotoInfo
    
    var body: some View {
        VStack {
            Image(image.getImageURL(isFullSize: true))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding()
            
            Text(image.author)
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
    }
}
