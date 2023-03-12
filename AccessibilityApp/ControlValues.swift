//
//  ControlValues.swift
//  AccessibilityApp
//
//  Created by Don Bouncy on 12/03/2023.
//

import SwiftUI

struct ControlValues: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value: \(value)")
            Button("Increment") {
                value += 1
            }
            .padding()
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction{
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

struct ControlValues_Previews: PreviewProvider {
    static var previews: some View {
        ControlValues()
    }
}
