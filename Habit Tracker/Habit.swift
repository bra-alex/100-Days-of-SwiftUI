//
//  Habit.swift
//  Habit Tracker
//
//  Created by Don Bouncy on 30/11/2022.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable{
    var id = UUID()
    let title: String
    let description: String
    let completion: Int
}
