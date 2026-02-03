//
//  iOS_PokedexApp.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/26/26.
//

import SwiftUI
import SwiftData

@main
struct iOS_PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreen()
        }
        .modelContainer(for: TeamPokemon.self)
    }
}
