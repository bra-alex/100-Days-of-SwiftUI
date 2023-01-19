//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Don Bouncy on 19/01/2023.
//

import UIKit

class ImageSaver: NSObject{
    func writePhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        print("Saved")
    }
}
