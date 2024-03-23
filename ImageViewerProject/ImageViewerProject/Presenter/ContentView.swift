//
//  ContentView.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var images: [PhotoInfo] = [PhotoInfo(photoID: "0", author: "Alejandro Escamilla", width: 100, height: 100, url: "https://unsplash.com/photos/yC-Yzbqy7PY"),
                                              PhotoInfo(photoID: "1", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/LNRyGwIJr5c"),
                                              PhotoInfo(photoID: "2", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/N7XodRrbzS0"),
                                              PhotoInfo(photoID: "3", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/Dl6jeyfihLk"),
                                              PhotoInfo(photoID: "4", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/y83Je1OC6Wc")]
    
    var body: some View {
        NavigationView {
             VStack {
                 SearchBar(text: $searchText, isSearching: $isSearching)
                 
                 if isSearching {
                     ImageList(images: filteredImages)
                 } else {
                     ImageList(images: images)
                 }
             }
             .navigationTitle("Image Gallery")
         }
         .onAppear {
             // 이미지를 load 한다.
             fetchImages()
         }
    }
    
    // Filtered images based on search text
    private var filteredImages: [PhotoInfo] {
        if searchText.isEmpty {
            return images
        } else {
            return images.filter { $0.author.contains(searchText) }
        }
    }
    
    // Fetch images from API
    private func fetchImages() {
        // Implement API fetching logic here
        // Populate images array with fetched data
    }
}

struct ImageList: View {
    var images: [PhotoInfo]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(images, id: \.photoID) { image in
                    ImageCell(image: image)
                }
            }
        }
        .padding()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search by author", text: $text)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: text) { _ in
                    isSearching = !text.isEmpty
                }
            
            if isSearching {
                Button(action: {
                    text = ""
                    isSearching = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
