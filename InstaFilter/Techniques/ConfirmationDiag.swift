//
//  ConfirmationDiag.swift
//  InstaFilter
//
//  Created by Don Bouncy on 18/01/2023.
//

import SwiftUI

struct ConfirmationDiag: View {
    @State private var bgColor = Color.black
    @State private var showingDialog = false
    var body: some View {
        ZStack{
            bgColor
                .ignoresSafeArea()
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .onTapGesture {
                    showingDialog = true
                }
                .confirmationDialog("Change Background", isPresented: $showingDialog) {
                    Button("Red") { bgColor = .red }
                    Button("Blue") { bgColor = .blue }
                    Button("Green") { bgColor = .green }
                    Button("Yellow") { bgColor = .yellow }
                    Button("Gray") { bgColor = .gray }
                    Button("Purple") { bgColor = .purple }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Choose a new background color")
                }

        }
    }
}

struct ConfirmationDiag_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDiag()
    }
}
