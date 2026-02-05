//
//  TeamViewModel.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/31/26.
//

import SwiftData
import Foundation

@MainActor
@Observable
class TeamViewModel {
    var showTeamFullAlert = false
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func addToTeam(
        pokemonId: Int,
        name: String,
        imageURL: String
    ) {
        let teamPokemon = TeamPokemon(
            pokemonId: pokemonId,
            name: name,
            spriteURL: imageURL
        )
        
        modelContext.insert(teamPokemon)
    }

    func removeFromTeam(_ pokemon: TeamPokemon) {
        modelContext.delete(pokemon)
    }
    
    func canAddToTeam(currentCount: Int) -> Bool {
        return currentCount < 6
    }
}
