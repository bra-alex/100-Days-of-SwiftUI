//
//  BundleDecodable.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import Foundation

extension Bundle{
    func decode <T: Codable> (_ file: String) -> T {
        guard let json = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find file")
        }
        
        guard let data = try? Data(contentsOf: json) else {
            fatalError("Could not convert to data")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode data")
        }
        
        return loaded
    }
}
