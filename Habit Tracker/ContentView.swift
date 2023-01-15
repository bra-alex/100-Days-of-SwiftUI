//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack{
            HabitsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
