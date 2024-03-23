//
//  MainViewModel.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
import UIKit
import Combine

class MainViewModel: ObservableObject {
    // subjects
    private let searchTextSubject = PassthroughSubject<String, Never>()
    private let getServerListSubject = PassthroughSubject<Void, Never>() // server load trigger
    private let errorSubject = PassthroughSubject<NetworkError, Never>() // 에러 응답
    // values
    private var bag = Set<AnyCancellable>()
    private var images: [PhotoInfo] = [PhotoInfo(id: "0", author: "Alejandro Escamilla", width: 100, height: 100, url: "https://unsplash.com/photos/yC-Yzbqy7PY"),
                                           PhotoInfo(id: "1", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/LNRyGwIJr5c"),
                                           PhotoInfo(id: "2", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/N7XodRrbzS0"),
                                           PhotoInfo(id: "3", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/Dl6jeyfihLk"),
                                           PhotoInfo(id: "4", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/y83Je1OC6Wc")]
    
    // binding datas
    @Published var displayedImages: [PhotoInfo] = []
    @Published var searchText: String = "" { // 검색어를 저장하는 프로퍼티
        didSet {
            // 검색어가 변경될 때마다 subject에 send
            searchTextSubject.send(searchText)
        }
    }
    @Published var isLoading: Bool = false // loading 중인지 여부
    @Published var isErrorAlert: Bool = false // error 가 발생했는지 여부
    @Published var errorMessage: String = "Error" // error 문구
    
    init() {
        bindInputs()
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    // Filtered images based on search text    
    public func fetchImages(for searchText: String) {
        if searchText.isEmpty {
            displayedImages = images
        } else {
            displayedImages = images.filter { $0.author.contains(searchText) }
        }
    }
    
    public func getList() {
        isLoading = true
        self.getServerListSubject.send()
    }
    
    private func bindInputs() {
        
        getServerListSubject
            .flatMap {
                ImageAPIRepository.fetchData(page: 0)
                    .catch { [weak self] error -> Empty<[PhotoInfo], Never> in
                        self?.isLoading = false
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                self.isLoading = false
                self.images = result
                self.fetchImages(for: "")
            })
            .store(in: &bag)
        
        searchTextSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.fetchImages(for: searchText)
            }
            .store(in: &bag)
    }
    
    private func bindOutputs() {
        // error handling
        errorSubject
            .map { _ in true }
            .assign(to: \.isErrorAlert, on: self)
            .store(in: &bag)
        errorSubject
            .map { $0.message }
            .assign(to: \.errorMessage, on: self)
            .store(in: &bag)
    }
}
