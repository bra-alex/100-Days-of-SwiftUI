//
//  FileManagement.swift
//  BucketList
//
//  Created by Don Bouncy on 03/03/2023.
//

import SwiftUI

struct FileManagement: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let str = "Str"
                let url = getDocumentDir().appendingPathComponent("test.txt", conformingTo: .text)
                
                do{
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let output = try String(contentsOf: url)
                    print(output)
                } catch {
                    print(String(describing: error))
                }
            }
    }
    
    func getDocumentDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct FileManagement_Previews: PreviewProvider {
    static var previews: some View {
        FileManagement()
    }
}
