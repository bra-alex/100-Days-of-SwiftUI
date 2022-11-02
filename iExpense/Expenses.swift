//
//  Expenses.swift
//  iExpense
//
//  Created by Don Bouncy on 02/11/2022.
//

import Foundation

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem]() {
        didSet{
            if let data = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(data, forKey: "Expenses Items")
            }
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Expenses Items"){
            if let data = try? JSONDecoder().decode([ExpenseItem].self, from: savedData){
                items = data
                return
            }
        }
        
        items = []
    }
}
