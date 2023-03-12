//
//  ContentView.swift
//  Bookworm
//
//  Created by Don Bouncy on 10/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            BooksView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
