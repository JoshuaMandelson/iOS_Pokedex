//
//  TeamViewModel.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/31/26.
//

import SwiftData
import Foundation
internal import Combine
import Observation

@MainActor
@Observable
class TeamViewModel: ObservableObject {

    var team: [TeamPokemon] = []
    var showTeamFullAlert = false

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTeam()
    }

    func fetchTeam() {
        let descriptor = FetchDescriptor<TeamPokemon>()
        team = (try? modelContext.fetch(descriptor)) ?? []
    }

    func addToTeam(
        pokemonId: Int,
        name: String,
        imageURL: String
    ) {
        guard team.count < 6 else {
            showTeamFullAlert = true
            return
        }

        guard !team.contains(where: { $0.pokemonId == pokemonId }) else {
            return
        }

        let teamPokemon = TeamPokemon(
            pokemonId: pokemonId,
            name: name,
            spriteURL: imageURL
        )

        modelContext.insert(teamPokemon)
        fetchTeam()
    }

    func removeFromTeam(_ pokemon: TeamPokemon) {
        modelContext.delete(pokemon)
        fetchTeam()
    }
}

