//
//  TipsyCloneView.swift
//  WeSplit
//
//  Created by Don Bouncy on 18/10/2022.
//

import SwiftUI

struct TipsyCloneView: View {
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
        VStack{
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GHS"))
                .keyboardType(.decimalPad)
                .focused($isFocused)
                .font(.system(size: 40))
                .padding(.top)
                .frame(width: 300, height: 150)
                .overlay(alignment: .topLeading) {
                    Text("Bill Amount")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
            
            VStack(alignment: .leading){
                HStack {
                    Text("Number of People: ")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .padding(.vertical)
                    
                    Spacer()
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 50,height: 100)
                    .clipped()
                    
                    Spacer()
                }
                
                VStack(alignment: .leading){
                    Text("Select tip")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .padding(.vertical)
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }.padding(.bottom, 40)
                
                HStack{
                    Text("Total Amount")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .padding(.vertical)
                    
                    Spacer()
                    
                    Text(total, format: currencyFormat)
                        .font(.system(size: 20))
                        .padding(.leading, 45)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Amount Per Person")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .padding(.vertical)
                    
                    Spacer()
                    
                    Text(totalPerPerson, format: currencyFormat)
                        .font(.system(size: 20))
                    
                    Spacer()
                }
                
                Spacer()
            }.padding()
                .background(Color(red: 0.843, green: 0.976, blue: 0.922))
        }
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

struct TipsyCloneView_Previews: PreviewProvider {
    static var previews: some View {
        TipsyCloneView()
    }
}

