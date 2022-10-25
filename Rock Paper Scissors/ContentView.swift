//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Don Bouncy on 25/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var option = ["rock", "paper", "scissors"].shuffled()
    @State private var selection = ["paper", "scissors", "rock"].shuffled()
    @State private var score = 0
    @State private var count = 0
    @State private var gameOver = false
    @State private var condition = Bool.random()
    @State private var randomOption = Int.random(in: 0 ... 2)
    
    var body: some View {
        VStack() {
            Spacer()
            Spacer()
            
            VStack(spacing: 20){
                Image(option[randomOption])
                    .renderingMode(.original)
                    .padding(.vertical)
                
                Text("Choose option to \(condition ? "win" : "lose")")
                    .font(.largeTitle.bold())
            }
            
            HStack{
                ForEach(selection, id: \.self) { select in
                    if select != option[randomOption]{
                        Button {
                            count += 1
                            checkOption(option: option[randomOption], selection: select)
                            shuffle()
                        } label: {
                            Image(select)
                                .renderingMode(.original)
                                .padding(.vertical)
                        }
                        .padding()
                    }
                }
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("Restart", action: reset)
            }message: {
                Text("Score: \(score)")
            }
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.title.bold())
            
            Spacer()
        }
        .padding()
    }
    
    private func shuffle(){
        if count == 10{
            gameOver = true
        }
        selection.shuffle()
        option.shuffle()
        randomOption = Int.random(in: 0 ... 2)
        condition = Bool.random()
    }
    
    private func checkOption(option: String, selection: String){
        if condition{
            switch(option){
                case "scissors":
                    if selection == "rock"{
                        return score += 1
                    }
                    
                case "rock":
                    if selection == "paper"{
                        return score += 1
                    }
                    
                case "paper":
                    if selection == "scissors"{
                        return score += 1
                    }
                    
                default:
                    return
            }
        }
        
        if !condition{
            switch(option){
            case "scissors":
                if selection != "rock"{
                    return score += 1
                }
                
            case "rock":
                if selection != "paper"{
                    return score += 1
                }
                
            case "paper":
                if selection != "scissors"{
                    return score += 1
                }
                
            default:
                return
            }
        }
        score -= 1
    }
    
    private func reset(){
        count = 0
        score = 0
        shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
