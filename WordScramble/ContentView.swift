//
//  ContentView.swift
//  WordScramble
//
//  Created by Don Bouncy on 28/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                VStack {
                    TextField("Enter your word", text: $newWord, onEditingChanged: { _ in
                        errorMessage = ""
                        showingError = false
                    })
                    .onSubmit(addNewWord)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(showingError ? RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1) : RoundedRectangle(cornerRadius: 10).stroke(Color.primary, lineWidth: 1))
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .padding(.bottom)
                    
                    Text("\(errorMessage)")
                        .opacity(showingError ? 1 : 0)
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                
                Text("Score: \(score)")
                    .frame(width: UIScreen.main.bounds.width - 20, alignment: .trailing)
                
                VStack{
                    List {
                        ForEach(usedWords, id: \.self) { word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(width: UIScreen.main.bounds.width - 20, alignment: .trailing)
                    
                    
                    HStack {
                        Button("Submit", action: addNewWord)
                            .padding()
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.white)
                            .opacity(newWord.isEmpty ? 0.5 : 1)
                            .disabled(newWord.isEmpty)
                        
                        Spacer()
                        
                        Button("New Word", action: startGame)
                            .padding()
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, alignment: .trailing)
                    .padding(.bottom)
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }
    
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsUrl){
                let words = startWords.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? words[0]
                return
            }
        }
        fatalError("Could not load start.txt")
    }
    
    func addNewWord(){
        showingError = false
        
        guard newWord != rootWord else {
            error(message: "Word can't be the same as the root word")
            return
        }
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            error(message: "Word should be greater than 3 characters")
            return
        }
        
        guard isNotUsed(word: answer) else {
            error(message: "Word already used")
            return
        }
        
        guard isPossible(word: answer) else {
            error(message: "Word can't be made from '\(rootWord)'")
            return
        }
        
        guard isCorrect(word: answer) else {
            error(message: "The word is misspelt")
            score -= 2
            return
        }
        
        calculateScore()
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func isNotUsed(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isCorrect(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func error(message: String){
        errorMessage = message
        showingError = true
    }
    
    func calculateScore(){
        var points = 0
        switch newWord.count {
        case 3...5:
            points = 7
            
        case 6...8:
            points = 10
            
        default:
            points = 0
            
        }
        score += points
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
