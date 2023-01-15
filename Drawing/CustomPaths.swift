//
//  CustomPaths.swift
//  Drawing
//
//  Created by Don Bouncy on 11/11/2022.
//

import SwiftUI

struct CustomPaths: View {
    var body: some View {
        Path{ path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            // closing up path (path.closePath) || stroke(style)
//            path.closeSubpath()
            
        }.stroke(LinearGradient(colors: [.red, .white, .blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
//        .fill(LinearGradient(colors: [.red, .white, .blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
            
    }
}

struct CustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CustomPaths()
    }
}
