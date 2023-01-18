//
//  AsyncImages.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 08/12/2022.
//

import SwiftUI

struct AsyncImages: View {
    var body: some View {
        VStack{
            //Basic Async Image
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
            
            //Async Image with placeholder and image control
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder:  {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            //Async Image with phases and error handling
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil{
                    Text("Couldn't find image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

struct AsyncImages_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImages()
    }
}
