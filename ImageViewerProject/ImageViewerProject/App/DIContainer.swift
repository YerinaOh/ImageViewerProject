//
//  DIContainer.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import Foundation
/// 의존성 주입을 위한 container
final class DIContainer {
    
    static let shared = DIContainer()
    
    /// main view di 적용
    /// - Returns: mainview
    public func getMainView() -> MainView {
        return MainView(viewModel: MainViewModel())
    }
}

