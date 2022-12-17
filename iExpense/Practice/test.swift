//
//  test.swift
//  iExpense
//
//  Created by Don Bouncy on 02/11/2022.
//

import SwiftUI

func bind<Value, Answer>(_ value: Value, to answer: (Value) -> Answer) -> Answer { answer(value) }

struct test: View {

  struct SomeGroup: Identifiable, RandomAccessCollection {
    typealias Indices = CountableRange<Int>
    public typealias Index = Int;
    var id: Int
    var displayName: String
    var numbers: [Int]

    public var endIndex: Index {
      return numbers.count - 1
    }

    public var startIndex: Index{
      return 0
    }

    public subscript(position: Int) -> Int {
      get { return numbers[position] }
      set { numbers[position] = newValue }
    }
  }

  var someGroups: [SomeGroup] = {
    return [
      SomeGroup(id: 0, displayName: "First", numbers: [1, 2, 3, 4]),
      SomeGroup(id: 1, displayName: "Second", numbers: [1, 3, 5, 7])
    ]
  }()

  var body: some View {
    List {
      ForEach(someGroups.indices) { section in
        bind(self.someGroups[section]) { someGroup in
          Section(header: Text(someGroup.displayName)) {
              ForEach(someGroup.numbers, id: \.self) { number in
              Text("\(number)")
            }
            .onDelete { self.delete(at: $0, in: section) }
          }
        }
      }
    }
    .listStyle(.grouped)
  }

  func delete(at offsets: IndexSet, in section: Int) {
    print("\(section), \(offsets.first!)")
  }

}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
