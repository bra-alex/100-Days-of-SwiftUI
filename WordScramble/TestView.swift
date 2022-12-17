//
//  TestView.swift
//  WordScramble
//
//  Created by Don Bouncy on 28/10/2022.
//

import SwiftUI

struct TestView: View {
    @State private var fileContent: [String] = []
    var body: some View {
        VStack {
            List(fileContent, id: \.self) {
                Text($0)
            }
            Button("Load File", action: checkSpelling)
        }
        
    }
    
    func loadBundle() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                fileContent = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
    func checkSpelling(){
        let word = "dreamer"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledWord = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let correct = mispelledWord.location == NSNotFound
        
        fileContent = [String(correct)]
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
