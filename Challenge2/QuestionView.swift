//
//  QuestionView.swift
//  Challenge2
//
//  Created by Don Bouncy on 31/10/2022.
//

import SwiftUI

struct QuestionView: View {
    @Binding var question: String
    @Binding var score: Int
    @Binding var remaining: Int
    @Binding var answer: String
    @Binding var isGenerated: Bool
    var checkAnswer: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack{
                    HStack {
                        Text("Questions: \(remaining)")
                            .padding()
                            .font(.headline)
                            .padding(.vertical)
                        
                        Spacer()
                        
                        Text("Score: \(score)")
                            .padding()
                            .font(.headline)
                            .padding(.vertical)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text(question)
                            .font(.title.bold())
                        
                        Text("=")
                            .font(.title2.bold())
                    }

                    TextField("Answer", text: $answer)
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(width: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10).stroke()
                        }
                        .onSubmit {
                            checkAnswer()
                        }
                    
                    Spacer()
                    
                    Button("Submit", action: checkAnswer)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                    Spacer()
                    
                }
            }
            .toolbar {
                Button("Reset", role: .destructive) {
                    withAnimation{
                        isGenerated.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: .constant("String"), score: .constant(10), remaining: .constant(5), answer: .constant(""), isGenerated: .constant(true), checkAnswer: {})
    }
}
