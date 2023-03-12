//
//  RatingView.swift
//  Bookworm
//
//  Created by Don Bouncy on 16/12/2022.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = "" 
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { i in
                image(for: i)
                    .foregroundColor(i > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = i
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating{
            return offImage ?? onImage
        }
        
        return onImage
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(5))
    }
}
