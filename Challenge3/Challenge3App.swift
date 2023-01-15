//
//  Challenge3App.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI

@main
struct Challenge3App: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
