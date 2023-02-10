//
//  ContentView.swift
//  InstaFilter
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var chooseImage = false
    @State private var filterIntensity = 0.2
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                     chooseImage = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .onChange(of: filterIntensity) {_ in applyFilter()}
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    Button("Save", action: saveImage)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .sheet(isPresented: $chooseImage) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage()}
        }
    }
    
    func saveImage(){
        
    }
    
    func changeFilter(){
        
    }
    
    func applyFilter(){
        currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
    
    func loadImage(){
        guard let inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyFilter()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
