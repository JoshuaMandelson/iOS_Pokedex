//
//  Creatures.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/26/26.
//
//

import Foundation

@Observable
class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/?limit=151"
    var count = 0
    var creaturesArray: [Creature] = []
    
    func getData() async {
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { return }

            self.creaturesArray = returned.results
            self.count = 151
        } catch {
            print("Error: Could not get data")
        }
    }
}
