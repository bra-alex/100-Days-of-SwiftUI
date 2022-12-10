//
//  SheetView.swift
//  iExpense
//
//  Created by Don Bouncy on 02/11/2022.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct SheetView: View {
    @State private var showSheet = false
    var body: some View {
        Button("Show second view") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            SecondView()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
