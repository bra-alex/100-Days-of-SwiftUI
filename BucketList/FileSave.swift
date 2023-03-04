//
//  FileSave.swift
//  BucketList
//
//  Created by Don Bouncy on 03/03/2023.
//

import Foundation

extension FileManager{
    func saveToDevice(fileName: String, fileContent: Data){
        let path = self.urls(for: .userDirectory, in: .userDomainMask)[0]
        let filePath = path.appendingPathComponent(fileName)
        
        do{
            try fileContent.write(to: filePath , options: .atomic)
        } catch {
            print(String(describing: error))
        }
    }
}
