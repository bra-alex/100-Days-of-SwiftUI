//
//  Metal.swift
//  Drawing
//
//  Created by Don Bouncy on 18/11/2022.
//

import SwiftUI

struct ColorCyclingRectangle: View{
    var amount = 0.0
    var start = 0.0
    var end = 0.0
    var steps = 100
    
    var body: some View{
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [color(for: value, brightness: 1),color(for: value, brightness: 0.5)], startPoint: UnitPoint(x: 1 - start, y: end), endPoint: UnitPoint(x: start, y: 1 - end)), lineWidth: 2)
            }
        }.drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingCircle: View{
    var amount = 0.0
    var steps = 100
    
    var body: some View{
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [color(for: value, brightness: 1),color(for: value, brightness: 0.5)], startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }.drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Metal: View {
    @State private var colorCycle = 0.0
    @State private var gradientPositionX = 0.0
    @State private var gradientPositionY = 0.0
    
    var body: some View {
        VStack{
            ColorCyclingCircle(amount: colorCycle)
            
            ColorCyclingRectangle(amount: colorCycle, start: gradientPositionX, end: gradientPositionY)
            
            Slider(value: $colorCycle)
                .padding()
            
            Slider(value: $gradientPositionX)
                .padding()
            
            Slider(value: $gradientPositionY)
                .padding()
        }
    }
}

struct Metal_Previews: PreviewProvider {
    static var previews: some View {
        Metal()
    }
}
