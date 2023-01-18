//
//  Bindings.swift
//  Bookworm
//
//  Created by Don Bouncy on 10/12/2022.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View{
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background {
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        }
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct Bindings: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            ButtonView(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct Bindings_Previews: PreviewProvider {
    static var previews: some View {
        Bindings()
    }
}
