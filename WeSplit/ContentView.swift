//
//  ContentView.swift
//  WeSplit
//
//  Created by Don Bouncy on 18/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var total: Double{
        let tipPercent = Double(tipPercentage)
        
        let tip = checkAmount * (tipPercent / 100)
        let total = checkAmount + tip
        
        return total
    }
    
    var totalPerPerson: Double{
        let persons = Double(numberOfPeople + 2)
        let tipPercent = Double(tipPercentage)
        
        let tip = checkAmount * (tipPercent / 100)
        let total = checkAmount + tip
        let amountPerPerson = total / persons
        
        return amountPerPerson
    }
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "GHS")
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GHS"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("Tip Percentage") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Total Amount") {
                    Text(total, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: currencyFormat)
                }
            }.navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
