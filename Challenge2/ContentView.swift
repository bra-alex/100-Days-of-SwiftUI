//
//  ContentView.swift
//  Challenge2
//
//  Created by Don Bouncy on 31/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var question = [""]
    @State private var answer = ""
    @State private var isGenerated = false
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var questionNumber = Int.random(in: 0..<20)
    @State private var score = 0
    @State private var gameOver = false
    @State private var count = 0
    @State private var remaining = 0
    
    @State private var questions = Questions()
    
    
    var body: some View {
        ZStack {
            if !isGenerated{
                VStack {
                    SettingsView(multiplicationTable: $multiplicationTable, numberOfQuestions: $numberOfQuestions){
                        generate(table: multiplicationTable - 2)
                    }.transition(.asymmetric(insertion: .scale.animation(.spring()), removal: .opacity))
                }
            }
            
            if isGenerated{
                QuestionView(question: $question[questionNumber], score: $score, remaining: $remaining, answer: $answer, isGenerated: $isGenerated){
                    checkAnswer(table: multiplicationTable - 2, answer: Int(answer) ?? 0)
                    answer = ""
                }
                .transition(.asymmetric(insertion: .scale.animation(.spring()), removal: .scale.animation(.spring())))
                .alert("Game Over", isPresented: $gameOver) {
                    Button("Restart") {
                        withAnimation{
                            isGenerated.toggle()
                        }
                    }
                } message: {
                    Text("Score: \(score.formatted())")
                }
            }
        }.onAppear{
            loadQuestions()
            loadAnswers()
        }
    }
    
    func loadQuestions(){
        if let questionPath = Bundle.main.urls(forResourcesWithExtension: "txt", subdirectory: "Questions"){
            questionPath.sorted(by: { path1, path2 in
                path1.lastPathComponent < path2.lastPathComponent
            }).forEach { url in
                if let tables = try? String(contentsOf: url){
                    questions.questions.append(tables.components(separatedBy: "\n"))
                }
            }
            return
        }
        fatalError("Could not load questions")
    }
    
    func loadAnswers(){
        if let answersPath = Bundle.main.urls(forResourcesWithExtension: "txt", subdirectory: "Answers"){
            answersPath.sorted(by: { path1, path2 in
                path1.lastPathComponent < path2.lastPathComponent
            }).forEach { url in
                if let tables = try? String(contentsOf: url){
                    let answers = tables.components(separatedBy: "\n")
                    
                    questions.answers.append(answers.map {Int($0)!})
                }
            }
            return
        }
        
        fatalError("Could not load answers")
    }
    
    func generate(table: Int){
        count = 0
        score = 0
        remaining = numberOfQuestions
        question = questions.questions[table]
        questionNumber = Int.random(in: 0..<20)
        isGenerated = true
    }
    
    func checkAnswer(table: Int, answer: Int){
        if answer == questions.answers[table][questionNumber]{
            score += 1
        }
        
        count += 1
        remaining = numberOfQuestions - count
        
        if count == numberOfQuestions{
            gameOver = true
            return
        }
        
        questionNumber = Int.random(in: 0..<20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
