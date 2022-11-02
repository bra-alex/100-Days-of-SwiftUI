//
//  SettingsView.swift
//  Challenge2
//
//  Created by Don Bouncy on 31/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var multiplicationTable: Int
    @Binding var numberOfQuestions: Int
    var generate : () -> ()
    
    var body: some View {
        VStack(alignment: .center){
            
            Spacer()
            Spacer()
            
            Text("Multiplication Table")
                .font(.title.bold())
            
            ForEach(1..<5) { num in
                HStack(alignment: .center, spacing: 20) {
                    ForEach(1..<4) { col in
                        Button {
                            multiplicationTable = col - 2 + 3 * num
                            print(multiplicationTable)
                        } label: {
                            Text((col - 2 + 3 * num) <= 12 ? "\((col - 2 + 3 * num))" : "")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(
                            (col - 2 + 3 * num) <= 12
                            ? Color(red: .random(in: 0.0..<0.45), green: .random(in: 0.0..<0.45), blue: .random(in: 0.0..<0.45))
                            : .white
                        )
                        .opacity(multiplicationTable == (col - 2 + 3 * num) ? 1 : 0.3)
                        .animation(.default, value: multiplicationTable)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                    }
                }
            }
            
            Spacer()
            
            Text("Number of Questions")
                .font(.title.bold())
            
            HStack(alignment: .center, spacing: 20) {
                ForEach(1..<5) { num in
                    Button {
                        numberOfQuestions = num * 5
                        print(numberOfQuestions)
                    } label: {
                        Text("\(num * 5)")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color(red: .random(in: 0.0..<0.45), green: .random(in: 0.0..<0.45), blue: .random(in: 0.0..<0.45)))
                    .opacity(numberOfQuestions == num * 5 ? 1 : 0.3)
                    .animation(.default, value: numberOfQuestions)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                    .padding(.horizontal, 5)
                }
            }
            
            Spacer()
            
            Button {
                generate()
//                generate(table: multiplicationTable - 2)
            } label: {
                Text("Generate")
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(multiplicationTable: .constant(2), numberOfQuestions: .constant(1), generate: {})
    }
}
