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
    private let searchTextSubject = PassthroughSubject<String, Never>() // search text 변화감지를 위한 trigger
    private let getServerListSubject = PassthroughSubject<Void, Never>() // server load trigger
    private let errorSubject = PassthroughSubject<NetworkError, Never>() // 에러 응답
    // values
    private var bag = Set<AnyCancellable>() // dispose bag
    private var images: [PhotoInfo] = [] // api loaded image list
    private var page: Int = 1 // 현재까지 load된 page수
    
    // binding datas
    @Published var displayedImages: [PhotoInfo] = [] // view에서 노출할 image data list
    @Published var searchText: String = "" { // 검색어
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
    
    /// list load
    public func getList() {
        isLoading = true
        self.getServerListSubject.send()
    }
    
    // Mission: Author 기반 검색(이미 받아온 List내에서 검색)
    /// 검색어에 따른 image list 로직
    /// - Parameter searchText: 검색어
    public func fetchImages(for searchText: String) {
        if searchText.isEmpty {
            displayedImages = images
        } else {
            displayedImages = images.filter { $0.author.contains(searchText) }
        }
    }
    
    /// 마지막 id에서 다음 page load
    /// - Parameter id: scroll된 cell의 id
    public func pagingFetch(id: String) {
        guard let index = displayedImages.firstIndex(where: { $0.id == id }) else { return }

        if index == displayedImages.count - 1 {
            page += 1
            getList()
        }
    }
    
    private func bindInputs() {
        // server api load subject
        getServerListSubject
            .flatMap {
                ImageAPIRepository.fetchData(page: self.page)
                    .catch { [weak self] error -> Empty<[PhotoInfo], Never> in
                        self?.isLoading = false
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                self.isLoading = false
                self.images += result
                self.fetchImages(for: "")
            })
            .store(in: &bag)
        // search text change subject
        searchTextSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.fetchImages(for: searchText)
            }
            .store(in: &bag)
    }
    
    private func bindOutputs() {
        // error handling subject
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
