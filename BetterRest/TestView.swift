//
//  TestView.swift
//  BetterRest
//
//  Created by Don Bouncy on 26/10/2022.
//

import SwiftUI

struct TestView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    var body: some View {
        VStack {
            //Stepper
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
            
            //DatePicker
            DatePicker("Please enter a time", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
                .datePickerStyle(.wheel)
            
            //Formatting Date
            Text(Date.now.formatted(date: .long, time: .shortened))
            Text(Date.now, format: .dateTime.day().month().year())
            Text(.now, style: .time)
        }
    }
    
//    func trivialExample(){
//        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
//        let hour = components.hour ?? 0
//        let minutes = components.minute ?? 0
//    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
