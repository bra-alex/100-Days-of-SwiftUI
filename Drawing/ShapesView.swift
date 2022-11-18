 //
//  ShapesView.swift
//  Drawing
//
//  Created by Don Bouncy on 11/11/2022.
//

import SwiftUI


struct Flower: Shape{
    var petalOffset: Double
    var petalWidth: Double
    
    var animatableData: AnimatablePair<Double, Double>{
        get{
            AnimatablePair(petalWidth, petalOffset)
            
        }
        set{
            petalWidth = newValue.first
            petalOffset = newValue.second
        }
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8){
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
                
        return path
    }
}

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape{
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotation = Angle.degrees(90)
        let modifiedStart = startAngle - rotation
        let modifiedEnd = endAngle - rotation
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
}


struct ShapesView: View {
    @State private var petalOffset = -62.0
    @State private var petalWidth = 0.0
    var body: some View {
        
        
        //       Triangle()
        //            .stroke(LinearGradient(colors: [.red, .white, .blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
        //            .frame(width: 200, height: 200)
        
        //        Arc(startAngle: .zero, endAngle: .degrees(110), clockwise: true)
        //            .strokeBorder(.pink, lineWidth: 10)
        //            .frame(width: 300, height: 300)
        
//        Circle()
//            .stroke(.pink, lineWidth: 10) // On the line of the border
//            .strokeBorder(.pink, lineWidth: 10) // Inside the border
        
        VStack{
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .stroke(.blue, lineWidth: 2)
//                .fill(.pink, style: FillStyle(eoFill: true))
                .fill(ImagePaint(image: Image("tree"), sourceRect: CGRect(x: 0.5, y: 0.5, width: 1, height: 0.2), scale: 1), style: FillStyle(eoFill: true))
//                .stroke(ImagePaint(image: Image("tree"), sourceRect: CGRect(x: 0.5, y: 0.5, width: 1, height: 0.2), scale: 1), lineWidth: 5)
                .padding( )
//                .animation(.default, value: petalWidth)
                .drawingGroup()
            
//            Text("Offset")
//            Slider(value: $petalOffset, in: -62...100)
//                .padding(.horizontal)
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...1000)
//                .padding(.horizontal)
        }
        .ignoresSafeArea()   
        .onAppear {
            withAnimation(.easeInOut(duration: 10)) {
                while(petalWidth < 1000){
                    petalWidth += 2  
                    petalOffset += 2
                }
            }
        }
         
    }
}

struct ShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesView()
    }
}
