//
//  TeamViewModel.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/31/26.
//

import SwiftData

@MainActor
class TeamViewModel: ObservableObject {

    private let modelContext: ModelContext
    @Published private(set) var team: [TeamPokemon] = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTeam()
    }

    func fetchTeam() {
        let descriptor = FetchDescriptor<TeamPokemon>()
        team = (try? modelContext.fetch(descriptor)) ?? []
    }

    func addToTeam(pokemon: Pokemon) {
        guard team.count < 6 else { return }

        guard !team.contains(where: { $0.pokemonId == pokemon.id }) else {
            return
        }

        let newPokemon = TeamPokemon(
            pokemonId: pokemon.id,
            name: pokemon.name,
            spriteURL: pokemon.sprite.frontDefault
        )

        modelContext.insert(newPokemon)
        fetchTeam()
    }

    func removeFromTeam(_ pokemon: TeamPokemon) {
        modelContext.delete(pokemon)
        fetchTeam()
    }
}
