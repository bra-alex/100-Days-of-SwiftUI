//
//  ContentView.swift
//  Animations
//
//  Created by Don Bouncy on 29/10/2022.
//

import SwiftUI

struct PivotTransition: ViewModifier{
    let rotation: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: PivotTransition(rotation: -90, anchor: .topLeading), identity: PivotTransition(rotation: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var secondHeart = 1.0
    @State private var rotation = 0.0
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    
    let letters = Array("Hey Baby")
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                //Implicit Animation
                /*
                 Image(systemName: "globe")
                 .imageScale(.large)
                 .foregroundColor(.primary)
                 .scaleEffect(animationAmount)
                 .blur(radius: (animationAmount - 1) * 2)
                 .animation(.default, value: animationAmount)
                 */
                
                //Customising Animations
                /*
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.primary)
                    .scaleEffect(animationAmount)
    //                .animation(
    //                    .interpolatingSpring(stiffness: 100, damping: 0.5)
    //                    .repeatForever(autoreverses: true),
    //                    value: animationAmount
    //                )
                    .animation(
                        .easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true),
                        value: animationAmount
                    )
                // .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.2, blendDuration: 1), value: animationAmount)
                
                Spacer()
                
                Button {
                    animationAmount += 1
                } label: {
                    Text("Start Animation")
                    
                }
                .padding(2)
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                }
            }.onAppear {
                animationAmount += 1
                 */
                
                //Animating Bindings
                /*
                Stepper("Increase Size", value: $animationAmount.animation(), in: 1...10, step: 0.5)
                
                Spacer()
                
                Button {
                    animationAmount += 1
                } label: {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.primary)
                }.scaleEffect(animationAmount)
                */
                
                //Explicit Animations
                /*
                Button {
                    withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)){
                        rotation += 360
                    }
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                }
                .foregroundColor(.red)
                .overlay{
                    Image(systemName: "heart")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .scaleEffect(secondHeart)
                        .opacity(2 - secondHeart)
                        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: secondHeart)
                }
                .onAppear{
                    secondHeart += 1
                    withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)){
                        animationAmount += 1
                    }
                }
                .scaleEffect(animationAmount)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 0, z: 1))
                 */
                
                //Animating gestures
                /*
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .trailing)
                    .frame(width: 300, height: 200)
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged{ drag in
                                withAnimation(.easeInOut){
                                    dragAmount = drag.translation
                                }
                            }
                            .onEnded{ _ in
                                withAnimation(.spring()){
                                    dragAmount = .zero
                                }
                            }
                    )
                 
                 HStack(spacing: 0) {
                     ForEach(0..<letters.count) { num in
                         Text(String(letters[num]))
                             .foregroundColor(.white)
                             .padding(5)
                             .background(enabled ? .blue : .red)
                             .offset(dragAmount)
                             .animation(.default.delay(Double(num)/20), value: dragAmount)
                     }
                 }
                 .gesture(
                     DragGesture()
                         .onChanged{ dragAmount = $0.translation }
                         .onEnded{ _ in
                             dragAmount = .zero
                             enabled.toggle()
                         }
                 )
                */
                
                //Transitions
                /*
                Button("Show Rectangle") {
                    withAnimation(.spring()){
                        enabled.toggle()
                    }
                }
                
                if enabled{
                    LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .trailing)
                        .frame(width: 300, height: 200)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                */
                
                //Custom Transitions
            }
            
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .trailing)
                .frame(width: 300, height: 200)
            
            if enabled{
                LinearGradient(colors: [.red, .yellow], startPoint: .topLeading, endPoint: .trailing)
                    .frame(width: 300, height: 200)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
