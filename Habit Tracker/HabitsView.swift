//
//  HabitsView.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 30/11/2022.
//

import SwiftUI

struct HabitsView: View {
    @State private var addHabit = false
    @StateObject var habits = Habits()
    
    var body: some View {
        Group {
            if (habits.habits.isEmpty) {
                Button {
                    addHabit = true
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add a habit")
                    }
                    .font(.largeTitle.bold())
                }
            } else {
                List {
                    ForEach(habits.habits) { habit in
                        NavigationLink {
                            DetailView(habits: habits, habit: habit)
                        } label: {
                            VStack(alignment: .leading, spacing: 5){
                                Text(habit.title)
                                    .font(.title3.bold())
                                
                                Text(habit.description)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: habits.deleteHabit)
                }
                .navigationTitle("Habit Tracker")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .toolbar {
                    Button {
                        addHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $addHabit) {
            AddHabit(habits: habits)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HabitsView()
        }
    }
}
