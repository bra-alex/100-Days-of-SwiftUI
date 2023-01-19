//
//  ViewControllers.swift
//  InstaFilter
//
//  Created by Don Bouncy on 19/01/2023.
//

import SwiftUI
import PhotosUI

struct ViewControllers: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var parent: ViewControllers
        
        init(_ parent: ViewControllers) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct PickImageView: View {
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    var body: some View {
        VStack{
            if let image = image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Select Image"){ showingImagePicker = true}
        }
        .sheet(isPresented: $showingImagePicker) {
            ViewControllers(image: $image)
        }
    }
}

struct PickImageView_Previews: PreviewProvider {
    static var previews: some View {
        PickImageView()
    }
}


