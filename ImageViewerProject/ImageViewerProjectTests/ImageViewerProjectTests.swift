//
//  ImageViewerProjectTests.swift
//  ImageViewerProjectTests
//
//  Created by ohyesrina on 3/23/24.
//

import XCTest
import Combine
@testable import ImageViewerProject

class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
        viewModel.images = ImageAPITestRepository.fetchLocalData()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    /// search text 가 empty일 때 전체 images 를 가져오는지 test
    func testFetchImagesWithEmptySearchText() {
        // Given
        let searchText = ""
        let expectedImages = viewModel.images
        
        // When
        viewModel.fetchImages(for: searchText)
        
        // Then
        XCTAssertEqual(viewModel.displayedImages.count, expectedImages.count)
    }
    
    /// search text 가 Alejandro일 때 images 를 가져오는지 test
    func testFetchImagesWithNonEmptySearchText() {
        // Given
        let searchText = "Alejandro"
        let expectedImages = viewModel.images.filter { $0.author.contains(searchText) }
        
        // When
        viewModel.fetchImages(for: searchText)
        
        // Then
        XCTAssertEqual(viewModel.displayedImages.count, expectedImages.count)
    }
    
    /// 마지막 id일 때, page 가 next page로 넘어가는지 test
    func testPagingFetchWithLastId() {
        // Given
        viewModel.displayedImages = viewModel.images
        let lastId = viewModel.displayedImages.last?.id ?? ""
        let initialPage = viewModel.page
        
        // When
        viewModel.pagingFetch(id: lastId)
        
        // Then
        XCTAssertEqual(viewModel.page, initialPage + 1)
    }
    
    /// 기타 id일 때, page 가 next page로 넘어가지 않고 남아있는지 확인
    func testPagingFetchWithNonLastId() {
        // Given
        viewModel.displayedImages = viewModel.images
        let nonLastId = "3"
        let initialPage = viewModel.page
        
        // When
        viewModel.pagingFetch(id: nonLastId)
        
        // Then
        XCTAssertEqual(viewModel.page, initialPage)
    }
    
    /// bundle data 를 initialize하는 method
    func testFetchDataParsing() {
        ImageAPITestRepository.fetchData(page: 0)
            .compactMap { $0 as? [ImageViewerProject.PhotoInfo] }
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { photoInfo in
                XCTAssertFalse(photoInfo.isEmpty)
            })
            .store(in: &cancellables)
    }
    
    /// 자동완성 keyword콜백 키워드
    func testGetAutoCompleteKeyword() {
        
        // Given
        viewModel.displayedImages = viewModel.images
        viewModel.searchText = "Alejandro"
        
        // When
        let keywords = viewModel.getAutoCompleteKeyword()
        
        // Then
        XCTAssertFalse(keywords.isEmpty)
    }
}
