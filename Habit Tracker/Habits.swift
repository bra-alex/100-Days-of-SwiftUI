//
//  Habits.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 30/11/2022.
//

import Foundation

class Habits: ObservableObject{
    @Published var title = ""
    @Published var description = ""
    @Published var counter = 0
    
    @Published var habits = [Habit](){
        didSet{
            encodeUserDefaults()
        }
    }
    
    init(){
        decodeUserDefaults()
    }
    
    func encodeUserDefaults(){
        if let data = try? JSONEncoder().encode(habits){
            UserDefaults.standard.set(data, forKey: "Habits")
        }
    }
    
    func decodeUserDefaults(){
        if let savedData = UserDefaults.standard.data(forKey: "Habits"){
            if let data = try? JSONDecoder().decode([Habit].self, from: savedData){
                habits = data
                return
            }
        }
    }
    
    func addHabit() {
        let habit = Habit(title: title, description: description, completion: counter)
        habits.append(habit)
        title = ""
        description = ""
    }
    
    func deleteHabit(at offset: IndexSet){
        habits.remove(atOffsets: offset)
    }
    
    func addCompletionCounter(to habit: Habit){
        guard let index = habits.firstIndex(of: habit) else { return }
        
        counter += 1
        let updatedCounter = habit.completion + counter
        let newHabit = Habit(title: habit.title, description: habit.description, completion: updatedCounter)
        habits[index] = newHabit
        
        counter = 0
    }
}
