//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Don Bouncy on 20/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showError = false
    @State private var gameOver = false
    @State private var title = ""
    @State private var message = ""
    @State private var score = 0
    @State private var count = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(title, isPresented: $showError) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text(message)
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }.padding()
        }
        .alert(title, isPresented: $gameOver) {
            Button("Restart", action: restart)
        } message: {
            Text(message)
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer{
            score += 1
            askQuestion()
        } else {
            title = "Wrong"
            message = "Wrong! That’s the flag of \(countries[number])"
            showError = true
        }
    }
    
    private func askQuestion() {
        count += 1
        if count == 8{
            title = "Game Over"
            message = "Final Score: \(score)"
            gameOver = true
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func restart(){
        count = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
