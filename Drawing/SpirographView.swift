//
//  SpirographView.swift
//  Drawing
//
//  Created by Don Bouncy on 18/11/2022.
//

import SwiftUI

struct Spirograph: Shape{
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    var amount: Double
    
    var animatableData: Double{
        get{ amount }
        set{ amount = newValue}
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int{
        var a = a
        var b = b
        
        while b != 0{
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        
        let diff = innerRadius - outerRadius
        
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for thetha in stride(from: 0, through: endPoint, by: 0.01){
            var x = diff * cos(thetha) + distance * cos(diff / outerRadius * thetha)
            var y = diff * sin(thetha) - distance * sin(diff / outerRadius * thetha)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if thetha == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }else{
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

struct SpirographView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 70.0
    @State private var distance = 96.0
    @State private var amount = 0.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1))
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner Radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer Radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding([.horizontal, .bottom])
            }
            
        }
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                while(amount < 1){
                    amount += 0.01
                }
            }
        }
    }
}

struct SpirographView_Previews: PreviewProvider {
    static var previews: some View {
        SpirographView()
    }
}
