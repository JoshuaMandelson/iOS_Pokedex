//
//  TeamView.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/31/26.
//

import SwiftUI
import SwiftData

struct TeamView: View {
    @State var teamVM: TeamViewModel
    @Query private var team: [TeamPokemon]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(red: 0/255, green: 50/255, blue: 100/255), Color(.cyan)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                // Header
                Text("My Team")
                    .font(Font.custom("Avenir Next Condensed", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                // Subtitle: team count
                Text("\(team.count)/6 Pokémon")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 10)

                if team.isEmpty {
                    Spacer()
                    Text("Your team is empty!")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.title3)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(team) { pokemon in
                                HStack(spacing: 20) {
                                    // Pokémon sprite
                                    AsyncImage(url: URL(string: pokemon.spriteURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .background(Color.white.opacity(0.2))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .shadow(radius: 5)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }

                                    // Pokémon name
                                    Text(pokemon.name.capitalized)
                                        .font(Font.custom("Avenir Next Condensed", size: 25))
                                        .foregroundColor(.white)
                                        .bold()

                                    Spacer()

                                    // Remove button
                                    Button {
                                        teamVM.removeFromTeam(pokemon)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .padding()
                                            .background(Color.white.opacity(0.2))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 10)
                    }
                }

                Spacer()
            }
            .padding(.top, 20)
        }
    }
}
