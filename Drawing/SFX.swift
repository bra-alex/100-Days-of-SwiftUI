//
//  SFX.swift
//  Drawing
//
//  Created by Don Bouncy on 18/11/2022.
//

import SwiftUI

struct SFX: View {
    @State private var amount = 0.0
    var body: some View {
        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -50)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -50)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 1, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: 50)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: 50)
//                    .blendMode(.screen)
//
//            }
//            .frame(width: 300, height: 300)
            
            Image("tree")
                .resizable()
                .scaledToFit()
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            Text("\(amount)")
                .foregroundColor(.white)
            Slider(value: $amount)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct SFX_Previews: PreviewProvider {
    static var previews: some View {
        SFX()
    }
}
