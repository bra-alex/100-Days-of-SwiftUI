//
//  BooksView.swift
//  Bookworm
//
//  Created by Don Bouncy on 16/12/2022.
//

import SwiftUI

struct BooksView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
        //        SortDescriptor(\.author, order: .reverse)
    ]) var books: FetchedResults<Book>
    
    @State private var addNewBook = false
    
    var body: some View {
        List{
            ForEach(books) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading){
                            Text(book.title ?? "N/A")
                                .font(.headline)
                                .foregroundColor(book.rating <= 1 ? .red : .primary)
                            
                            Text(book.author ?? "N/A")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteBooks)
        }
        .navigationTitle("Bookworm")
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                if books.count > 0{
                    EditButton()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addNewBook.toggle()
                } label: {
                    Label("Add Book", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $addNewBook) {
            AddBookView()
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
