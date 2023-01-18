//
//  Delete.swift
//  iExpense
//
//  Created by Don Bouncy on 02/11/2022.
//

import SwiftUI

struct Delete: View {
    @State private var num = [Int]()
    @State private var currentNum = 1
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(num, id: \.self) {
                        Text("Row number \($0)")
                    }.onDelete(perform: delete)
                }
                
                Button("Add Number"){
                    num.append(currentNum)
                    currentNum += 1
                }
            }.toolbar {
                EditButton()
            }
        }
    }
    
    func delete(at offset: IndexSet){
        num.remove(atOffsets: offset)
    }
}

struct Delete_Previews: PreviewProvider {
    static var previews: some View {
        Delete()
    }
}
