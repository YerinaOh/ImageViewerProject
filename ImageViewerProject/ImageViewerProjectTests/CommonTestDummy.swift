//
//  CommonTestDummy.swift
//  ImageViewerProject
//
//  Created by ohyesrina on 3/24/24.
//

import Foundation

extension Bundle {
    
    static func loadJSONData<T: Decodable>(filename: String, type: T.Type) -> T? {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        
        if let url = bundle?.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: url))
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return nil
    }
}
