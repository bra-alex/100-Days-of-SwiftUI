//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 07/12/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orders = Orders()
    
    var body: some View {
        NavigationStack {
            OrderView(order: orders)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
