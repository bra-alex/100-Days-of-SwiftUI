//
//  ContentView.swift
//  BetterRest
//
//  Created by Don Bouncy on 26/10/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var calculateBedTime: String{
        var message = ""
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            message = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            message = "Couldn't be calculated"
        }
        
        return message
    }
    
    init() {
       let navBarAppearance = UINavigationBar.appearance()
       navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
       navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
     }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("stars")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(maxWidth: UIScreen.main.bounds.width, minHeight:  UIScreen.main.bounds.height, maxHeight: UIScreen.main.bounds.height)
                    .overlay(content: {
                        Color(red: 0.189, green: 0.094, blue: 0.457)
                            .blendMode(.difference)
                    })
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .center, spacing: 15){
                        Text("Recommended Bedtime")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "clock")
                                .font(.largeTitle)
                            Text(calculateBedTime)
                                .font(.largeTitle)
                        }.foregroundColor(.white)
                    }
                    .padding()
                    .frame(minWidth: 300, maxWidth: .infinity, minHeight: 0)
                    
                    Spacer()
                    
                    HStack(){
                        Text("When do you want to wake up?")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .colorInvert()
                            .colorMultiply(.white)
                            .labelsHidden()
                    }.padding()
                    
                    
                    HStack{
                        Text("Hours of sleep")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(sleepAmount.formatted()) hours")
                            .foregroundColor(.white)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                            .colorInvert()
                            .colorMultiply(.white)
                            .frame(width: 90)
                            .clipped()
                            .labelsHidden()
                    }.padding()
                    
                    HStack{
                        Text("Daily coffee intake")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        Picker("Number of cups", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text($0 == 1 ? "1 cup": "\($0) cups")
                            }
                        }
                        .fontWeight(.bold)
                        .tint(.white)
                    }.padding()
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }.navigationTitle("Better Rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
