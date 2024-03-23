//
//  ImageCell.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import SwiftUI

struct ImageCell: View {
    var image: PhotoInfo
    
    var body: some View {
        NavigationLink(destination: DetailView(image: image)) {
            VStack(alignment: .leading) {
                Image(image.url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
                
                Text(image.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
    }
}
