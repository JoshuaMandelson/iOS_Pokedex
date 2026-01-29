//
//  Creature.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/27/26.
//

import Foundation

//Defines the structure for the individual items within the results array. Hashable: Allows each item to be uniquely identified, which is required for SwiftUI lists.
struct Creature: Codable, Hashable {
    var name: String
    var url: String
}
