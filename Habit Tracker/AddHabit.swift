//
//  AddHabit.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 30/11/2022.
//

import SwiftUI

struct AddHabit: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView {
            Form {
                Section("Title") {
                    TextField("Title", text: $habits.title)
                }
                
                Section("Description") {
                    TextField("Description", text: $habits.description)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(.borderless)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        habits.addHabit()
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddHabit(habits: Habits())
        }
    }
}
