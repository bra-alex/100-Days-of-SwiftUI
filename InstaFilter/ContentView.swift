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
    @State private var processedImage: UIImage?
    
    @State private var chooseImage = false
    @State private var showFilters = false
    
    @State private var scale = 1.0
    @State private var radius = 1.0
    @State private var filterIntensity = 0.2
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
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
                        .onChange(of: filterIntensity) {_ in applyFilter()}
                }
                .padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: $radius, in: 1...100, step: 0.1)
                        .onChange(of: radius) {_ in applyFilter()}
                }
                .padding(.vertical)
                
                HStack {
                    Text("Scale")
                    Slider(value: $scale, in: 1...100, step: 0.1)
                        .onChange(of: scale) {_ in applyFilter()}
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter"){
                        showFilters = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: saveImage)
                        .disabled(image == nil ? true : false)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .sheet(isPresented: $chooseImage) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage()}
            .confirmationDialog("Select Filter", isPresented: $showFilters) {
                Group{
                    Button("X-Ray"){ changeFilter(to: .xRay())}
                    Button("Color Invert"){ changeFilter(to: .colorInvert())}
                }
                
                Group{
                    Button("Edges"){ changeFilter(to: .edges())}
                    Button("Gloom"){ changeFilter(to: .gloom())}
                    Button("Vignette"){ changeFilter(to: .vignette())}
                    Button("Sepia Tone"){ changeFilter(to: .sepiaTone())}
                    Button("Unsharp Mask"){ changeFilter(to: .unsharpMask())}
                }
                
                Group{
                    Button("Pixellate"){ changeFilter(to: .pixellate())}
                    Button("Crystallize"){ changeFilter(to: .crystallize())}
                    Button("Twirl Distortion"){ changeFilter(to: .twirlDistortion())}
                }
                
                Group{
                    Button("Motion Blur"){ changeFilter(to: .motionBlur())}
                    Button("Gaussian Blur"){ changeFilter(to: .gaussianBlur())}
                }
                
                Button("Cancel", role: .cancel){ }
            } message: {
                
            }

        }
    }
    
    func saveImage(){
        guard let processedImage else { return }
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Saved")
        }
        
        imageSaver.errorHandler = {
            print($0.localizedDescription)
        }
        
        imageSaver.writePhotoAlbum(image: processedImage )
    }
    
    func changeFilter(to filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
    
    func applyFilter(){
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(radius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(scale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
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
