//
//  ContentView.swift
//  iExpense
//
//  Created by Don Bouncy on 01/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var personalExpenses: [ExpenseItem]{
            expenses.items.filter{$0.type == "Personal"}
    }
    
    var businessExpenses: [ExpenseItem]{
        expenses.items.filter{$0.type == "Business"}
    }

    var body: some View {
        NavigationView {
            List() {
                if !personalExpenses.isEmpty{
                    Section("Personal Expenses"){
                        ForEach(personalExpenses) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .padding(.vertical, 3)
                                            .font(.headline)
                                
                                        Text(item.type)
                                            .padding(.bottom, 3)
                                            .font(.subheadline)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .foregroundColor(
                                            item.amount <= 10 ? .green
                                            : item.amount <= 100 ? .yellow
                                            : item.amount > 100 ? .red
                                            : .black
                                        )
                                }
                                .accessibilityElement()
                                .accessibilityLabel("\(item.name) \(item.amount)")
                                .accessibilityHint(item.type)
                        }.onDelete{ deleteExpense(at: $0, in: personalExpenses) }
                    }
                }
                
                if !businessExpenses.isEmpty{
                    Section("Business Expenses"){
                        ForEach(businessExpenses) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .padding(.vertical, 3)
                                            .font(.headline)

                                        Text(item.type)
                                            .padding(.bottom, 3)
                                            .font(.subheadline)
                                    }

                                    Spacer()

                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .foregroundColor(
                                            item.amount <= 10 ? .green
                                            : item.amount <= 100 ? .yellow
                                            : item.amount > 100 ? .red
                                            : .black
                                        )
                                }
                        }.onDelete{ deleteExpense(at: $0, in: businessExpenses) }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func deleteExpense(at offset: IndexSet, in groups: [ExpenseItem] ) {
        let index = expenses.items.firstIndex{$0.id == groups[offset.first!].id}!
        expenses.items.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
