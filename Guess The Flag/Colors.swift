//
//  Colors.swift
//  Guess The Flag
//
//  Created by Don Bouncy on 21/10/2022.
//

import SwiftUI

struct Colors: View {
    var body: some View {
        ZStack(alignment: .center) {
            //Solid Colors
            /*
             VStack(spacing: 0){
             Color.red
             Color.yellow
             }
             Text("This is supposed to be")
             .foregroundStyle(.secondary)
             .padding(50)
             .background(.thinMaterial)
             */
            
            //Gradients
            //Linear Gradient
            //No Stops
            // /*
             LinearGradient(colors: [.red, .yellow, .green], startPoint: .top, endPoint: .bottom)
             LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green]), startPoint: .bottom, endPoint: .top)
             // */
            
            //Stops
            // /*
             LinearGradient(stops: [
                 .init(color: .red, location: 0.33),
                 .init(color: .yellow, location: 0.34),
                 .init(color: .yellow, location: 0.66),
                 .init(color: .green, location: 0.67)
             ], startPoint: .topLeading, endPoint: .bottomTrailing)
             .blendMode(.colorBurn)
            
             LinearGradient(gradient: Gradient(stops: [
                 .init(color: .red, location: 0.33),
                 .init(color: .yellow, location: 0.34),
                 .init(color: .yellow, location: 0.66),
                 .init(color: .green, location: 0.67)
             ]), startPoint: .bottomLeading, endPoint: .topTrailing)
             .blendMode(.colorDodge)
             // */
            
            //Radial Gradient
            // /*
            RadialGradient(colors: [.red, .yellow, .green], center: .center, startRadius: 10, endRadius: 300)
                .blendMode(.multiply)
            
            RadialGradient(stops: [
                .init(color: .red, location: 0.33),
                .init(color: .yellow, location: 0.34),
                .init(color: .yellow, location: 0.66),
                .init(color: .green, location: 0.67)
            ], center: .center, startRadius: 10, endRadius: 250)
            .blendMode(.difference)
            // */
            
            //Angular Gradient
            AngularGradient(colors: [.red, .yellow, .green], center: .center, angle: .degrees(66))
                .blendMode(.difference)
            AngularGradient(stops: [
                .init(color: .red, location: 0.33),
                .init(color: .yellow, location: 0.34),
                .init(color: .yellow, location: 0.66),
                .init(color: .green, location: 0.67)
            ], center: .center, angle: .degrees(66))
            .blendMode(.difference)
            
            Image(systemName: "figure.fall")
                .font(.system(size: 100))
                .foregroundColor(.white)
                .blendMode(.difference)

            
            
        }.ignoresSafeArea()
    }
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        Colors()
    }
}
