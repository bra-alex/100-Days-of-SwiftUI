//
//  MultiLineView.swift
//  Bookworm
//
//  Created by Don Bouncy on 10/12/2022.
//

import SwiftUI

struct MultiLineView: View {
    @AppStorage("notes") private var notes = ""
    var body: some View {
        NavigationStack{
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct MultiLineView_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineView()
    }
}
