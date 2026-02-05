//
//  TeamModel.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/31/26.
//

import SwiftData

@Model
class TeamPokemon {
    var pokemonId: Int 
    var name: String
    var spriteURL: String

    init(pokemonId: Int, name: String, spriteURL: String) {
        self.pokemonId = pokemonId
        self.name = name
        self.spriteURL = spriteURL
    }
}
