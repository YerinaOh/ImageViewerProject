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
                if isSearching, (viewModel.displayedImages.count != viewModel.images.count) { // Mission: 자동완성 옵션 on
                    KeywordScrollView(keywords: viewModel.getAutoCompleteKeyword()) { keyword in
                        viewModel.searchText = keyword
                    }
                }
                ZStack {
                    ScrollViewReader { reader in
                        ScrollView {
                            // Mission: Grid Image
                            let item = GridItem(.flexible(), spacing: 6, alignment: nil)
                            let columns = Array(repeating: item, count: 3)
                            let images = viewModel.displayedImages
                            
                            LazyVGrid(columns: columns) {
                                ForEach(images, id: \.id) { image in
                                    ImageCell(image: image)
                                        .onAppear {
                                            if !isSearching {
                                                viewModel.pagingFetch(id: image.id) // Mission: infinite scroll
                                            }
                                        }
                                }
                            }.onChange(of: viewModel.searchText) { _ in
                                withAnimation {
                                    // 검색어가 변경될 때마다 ScrollView를 맨 위로 스크롤
                                    reader.scrollTo(viewModel.displayedImages.first?.id ?? "0")
                                }
                            }
                        }
                        .padding()
                    }
                    if viewModel.isLoading {
                         ProgressView("Loading...")
                             .progressViewStyle(CircularProgressViewStyle())
                     }
                 }
             }
             .navigationTitle("Image Gallery")
         }
         .onAppear {
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

struct KeywordScrollView: View {
    var keywords: [String]
    var onKeywordTapped: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(keywords, id: \.self) { keyword in
                    Button(action: {
                        onKeywordTapped(keyword)
                    }) {
                        Text(keyword)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        DIContainer.shared.getMainView()
    }
}
