//
//  AnimateShapes.swift
//  Drawing
//
//  Created by Don Bouncy on 18/11/2022.
//

import SwiftUI

struct CheckerBoard: Shape{
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double>{
        get {AnimatablePair(Double(rows), Double(columns))}
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}


struct Trapezoid: Shape{
    var insetAmount: Double
    
    var animatableData: Double{
        get {insetAmount}
        set {insetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct AnimateShapes: View {
    @State private var insetAmount = 0.0
    @State private var rows = 5
    @State private var columns = 5
    var body: some View {
//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                withAnimation{
//                    insetAmount = Double.random(in: 10...100)
//                }
//            }
        
        CheckerBoard(rows: rows, columns: columns)
            .fill(.blue)
            .frame(width: 300, height: 300)
            .onTapGesture {
                withAnimation(.linear(duration: 3)){
                    rows = 10
                    columns = 20
                }
            }
    }
}

struct AnimateShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimateShapes()
    }
}
