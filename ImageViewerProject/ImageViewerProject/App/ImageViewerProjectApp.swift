//
//  ImageViewerProjectApp.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/23/24.
//

import SwiftUI

@main
struct ImageViewerProjectApp: App {
    var body: some Scene {
        WindowGroup {
            DIContainer.shared.getMainView()
        }
    }
}
