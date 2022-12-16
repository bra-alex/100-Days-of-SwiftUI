//
//  AddBookView.swift
//  Bookworm
//
//  Created by Don Bouncy on 16/12/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 0
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var valid: Bool{
        let title = title.trimmingCharacters(in: .whitespaces)
        let author = author.trimmingCharacters(in: .whitespaces)
        
        if title.isEmpty || author.isEmpty{
                return true
        }
        
        return false
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a Review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let book = Book(context: moc)
                        book.id = UUID()
                        book.title = title
                        book.author = author
                        book.genre = genre
                        book.review = review
                        book.rating = Int16(rating)
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(valid)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
