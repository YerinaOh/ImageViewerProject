//
//  MainView.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    @State private var isSearching: Bool = false
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, isSearching: $isSearching)
                ZStack {
                    ScrollView {
                        // Mission: Grid Image
                        let item = GridItem(.flexible(), spacing: 6, alignment: nil)
                        let columns = Array(repeating: item, count: 3)
                        let images = viewModel.displayedImages
                        
                        LazyVGrid(columns: columns) {
                            ForEach(images, id: \.id) { image in
                                ImageCell(image: image)
                                    .onAppear {
                                        viewModel.pagingFetch(id: image.id) // Mission: infinite scroll
                                    }
                            }
                        }
                    }
                    .padding()
                    if viewModel.isLoading {
                         ProgressView("Loading...")
                             .progressViewStyle(CircularProgressViewStyle())
                     }
                 }
             }
             .navigationTitle("Image Gallery")
         }
         .onAppear {
             // 이미지를 load 한다.
             viewModel.getList()
         }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search by author", text: $text)
                .textInputAutocapitalization(.words) // Mission: 자동완성 옵션 on
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        DIContainer.shared.getMainView()
    }
}
