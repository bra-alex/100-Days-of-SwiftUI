//
//  PicturesView.swift
//  AccessibilityApp
//
//  Created by Don Bouncy on 12/03/2023.
//

import SwiftUI

struct PicturesView: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .accessibilityLabel(labels[selectedPicture])
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
    }
}

struct PicturesView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesView()
    }
}
