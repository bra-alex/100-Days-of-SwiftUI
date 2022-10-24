//
//  ContentView.swift
//  Challenge1
//
//  Created by Don Bouncy on 19/10/2022.
//

import SwiftUI
import Foundation

extension UnitDuration {
    static let SecondsPerDay: Double = 86_400
    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: SecondsPerDay))
}

enum TempConversions: CaseIterable{
    case celcius, fahrenheit, kelvin
    
    var symbol: String{
        switch self {
        case .celcius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
    
    var unit: UnitTemperature{
        switch self {
        case .celcius:
            return UnitTemperature.celsius
        case .fahrenheit:
            return UnitTemperature.fahrenheit
        case .kelvin:
            return UnitTemperature.kelvin
        }
    }
}

enum LengthConversions: CaseIterable{
    case  meters, kilometers, feet, yards, miles
    
    var symbol: String{
        switch self {
        case .meters:
            return "m"
        case .kilometers:
            return "km"
        case .feet:
            return "ft"
        case .yards:
            return "yd"
        case .miles:
            return "mi"
            
        }
    }
    
    var unit: UnitLength{
        switch self {
        case .meters:
            return UnitLength.meters
        case .kilometers:
            return UnitLength.kilometers
        case .feet:
            return UnitLength.feet
        case .yards:
            return UnitLength.yards
        case .miles:
            return UnitLength.miles
            
        }
    }
}

enum TimeConversions: CaseIterable{
    case  seconds, minutes, hours, days
    
    var symbol: String{
        switch self {
        case .seconds:
            return "s"
        case .minutes:
            return "min"
        case .hours:
            return "hr"
        case .days:
            return "days"
        }
    }
    
    var unit: UnitDuration{
        switch self {
        case .seconds:
            return UnitDuration.seconds
        case .minutes:
            return UnitDuration.minutes
        case .hours:
            return UnitDuration.hours
        case .days:
            return UnitDuration.days
        }
    }
}

enum VolumeConversions: CaseIterable{
    case  milliliters, liters, cups, pints, gallons
    
    var symbol: String{
        switch self {
        case .milliliters:
            return "mL"
        case .liters:
            return "L"
        case .cups:
            return "c"
        case .pints:
            return "pt"
        case .gallons:
            return "gal"
        }
    }
    
    var unit: UnitVolume{
        switch self {
        case .milliliters:
            return UnitVolume.milliliters
        case .liters:
            return UnitVolume.liters
        case .cups:
            return UnitVolume.cups
        case .pints:
            return UnitVolume.pints
        case .gallons:
            return UnitVolume.gallons
        }
    }
}

struct ContentView: View {
    @FocusState private var isFocused: Bool
    
    @State private var temp = 0.0
    @State private var inintialSelectedTemp = TempConversions.celcius
    @State private var finalSelectedTemp = TempConversions.fahrenheit
    
    @State private var length = 0.0
    @State private var inintialSelectedLength = LengthConversions.meters
    @State private var finalSelectedLength = LengthConversions.kilometers
    
    @State private var time = 0.0
    @State private var inintialSelectedTime = TimeConversions.seconds
    @State private var finalSelectedTime = TimeConversions.minutes
    
    @State private var volume = 0.0
    @State private var inintialSelectedVolume = VolumeConversions.milliliters
    @State private var finalSelectedVolume = VolumeConversions.liters
    
    var body: some View {
        NavigationView{
            Form{
                Section("Temperature Conversion") {
                    tempConversion
                }
                
                Section("Length Conversion") {
                    lengthConversion
                }
                
                Section("Time Conversion") {
                    timeConversion
                }
                
                Section("Volume Conversion") {
                    volumeConversion
                }
                
            }.navigationTitle("Convertor")
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

extension ContentView{
    
    var convertedTemp: String{
        let initial = Measurement(value: temp, unit: inintialSelectedTemp.unit)
        let final = initial.converted(to: finalSelectedTemp.unit)
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        
        return formatter.string(from: final)
    }
    
    @ViewBuilder var tempConversion: some View{
        HStack {
            TextField("Temperature", value: $temp, format: .number)
                .keyboardType(.decimalPad)
                .focused($isFocused)
            
            Picker("", selection: $inintialSelectedTemp) {
                ForEach(TempConversions.allCases, id: \.self) { temp in
                    Text(temp.symbol)
                }
            }
        }
        
        HStack{
            Text("\(convertedTemp)")
            Picker("", selection: $finalSelectedTemp) {
                ForEach(TempConversions.allCases, id: \.self) { temp in
                    Text(temp.symbol)
                }
            }
        }
    }
}

extension ContentView{
    var convertedLength: String{
        let initial = Measurement(value: length, unit: inintialSelectedLength.unit)
        let final = initial.converted(to: finalSelectedLength.unit)
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        
        return formatter.string(from: final)
    }
    
    @ViewBuilder var lengthConversion: some View{
        HStack {
            TextField("Length", value: $length, format: .number)
                .keyboardType(.decimalPad)
                .focused($isFocused)
            
            Picker("", selection: $inintialSelectedLength) {
                ForEach(LengthConversions.allCases, id: \.self) { length in
                    Text(length.symbol)
                }
            }
        }
        
        HStack{
            Text("\(convertedLength)")
            Picker("", selection: $finalSelectedLength) {
                ForEach(LengthConversions.allCases, id: \.self) { length in
                    Text(length.symbol)
                }
            }
        }
    }
}

extension ContentView{
    var convertedTime: String{
        let initial = Measurement(value: time, unit: inintialSelectedTime.unit)
        let final = initial.converted(to: finalSelectedTime.unit)
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        
        return formatter.string(from: final)
    }
    
    @ViewBuilder var timeConversion: some View{
        HStack {
            TextField("Time", value: $time, format: .number)
                .keyboardType(.decimalPad)
                .focused($isFocused)
            
            Picker("", selection: $inintialSelectedTime) {
                ForEach(TimeConversions.allCases, id: \.self) { time in
                    Text(time.symbol)
                }
            }
        }
        
        HStack{
            Text("\(convertedTime)")
            Picker("", selection: $finalSelectedTime) {
                ForEach(TimeConversions.allCases, id: \.self) { time in
                    Text(time.symbol)
                }
            }
        }
    }
}

extension ContentView{
    var convertedVolume: String{
        let initial = Measurement(value: volume, unit: inintialSelectedVolume.unit)
        let final = initial.converted(to: finalSelectedVolume.unit)
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        
        return formatter.string(from: final)
    }
    
    @ViewBuilder var volumeConversion: some View{
        HStack {
            TextField("Volume", value: $volume, format: .number)
                .keyboardType(.decimalPad)
                .focused($isFocused)
            
            Picker("", selection: $inintialSelectedVolume) {
                ForEach(VolumeConversions.allCases, id: \.self) { volume in
                    Text(volume.symbol)
                }
            }
        }
        
        HStack{
            Text("\(convertedVolume)")
            Picker("", selection: $finalSelectedVolume) {
                ForEach(VolumeConversions.allCases, id: \.self) { volume in
                    Text(volume.symbol)
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
