//
//  DetailView.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 01/12/2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var habits: Habits
    @State var habit: Habit
    var body: some View {
        Form{
            Section("Description"){
                Text(habit.description)
            }
            
            Section("Completion"){
                Text("\(habit.completion) times")
            }
        }
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                habits.addCompletionCounter(to: habit)
            } label: {
                Image(systemName: "checkmark.circle")
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(habits: Habits(), habit: Habits().habits[0])
        }
    }
}
