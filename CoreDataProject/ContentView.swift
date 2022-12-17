//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Check for changes before saving
        /*
         Button("Save"){
            if moc.hasChanges {
                try? moc.save()
            }
         }
         */
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
