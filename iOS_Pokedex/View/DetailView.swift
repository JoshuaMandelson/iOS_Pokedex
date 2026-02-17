//
//  DetailView.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/27/26.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let creatureURL: String
    let pokemonId: Int
    let name: String

    @Query private var team: [TeamPokemon]
    @State private var detail = CreatureDetail()
    @State var teamVM: TeamViewModel

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(red: 0/255, green: 50/255, blue: 100/255), Color(.cyan)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Name
                Text(name.capitalized)
                    .font(Font.custom("Avenir Next Condensed", size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                // Divider
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.horizontal)
                
                // Pokémon image
                AsyncImage(url: URL(string: detail.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                } placeholder: {
                    ProgressView()
                        .frame(width: 180, height: 180)
                }
                
                // Stats
                HStack(spacing: 40) {
                    VStack {
                        Text("Height")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(String(format: "%.1f", detail.height))
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                    VStack {
                        Text("Weight")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(String(format: "%.1f", detail.weight))
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                // Base Stats Section
                VStack(spacing: 12) {
                    Text("Base Stats")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        BaseStatView(statName: "HP", statValue: detail.baseStats["hp"] ?? 0)
                        BaseStatView(statName: "Attack", statValue: detail.baseStats["attack"] ?? 0)
                        BaseStatView(statName: "Defense", statValue: detail.baseStats["defense"] ?? 0)
                        BaseStatView(statName: "Sp. Attack", statValue: detail.baseStats["special-attack"] ?? 0)
                        BaseStatView(statName: "Sp. Defense", statValue: detail.baseStats["special-defense"] ?? 0)
                        BaseStatView(statName: "Speed", statValue: detail.baseStats["speed"] ?? 0)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Add to Team Button
                Button {
                    if teamVM.canAddToTeam(currentCount: team.count) {
                        teamVM.addToTeam(
                            pokemonId: pokemonId,
                            name: name,
                            imageURL: detail.imageURL
                        )
                    } else{
                        teamVM.showTeamFullAlert = true
                    }
                } label: {
                    Text("Add to Team")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5, x: 3, y: 3)
                }
                .padding(.horizontal)
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
        }
        .alert(
            "Team Full",
            isPresented: $teamVM.showTeamFullAlert
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You can only have 6 Pokémon on your team.")
        }
        .task {
            detail.urlString = creatureURL
            await detail.getData()
        }
    }
}

struct BaseStatView: View {
    let statName: String
    let statValue: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text(statName)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            ZStack {
                // Background bar
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 20)
                    .foregroundColor(.white.opacity(0.2))
                
                // Progress bar
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: max(0, min(geometry.size.width, geometry.size.width * CGFloat(statValue) / 200)), height: 20)
                        .foregroundColor(colorForStat(statValue))
                }
                .frame(height: 20)
                
                // Stat value text
                Text("\(statValue)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func colorForStat(_ value: Int) -> Color {
        switch value {
        case 0..<50:
            return .red.opacity(0.8)
        case 50..<80:
            return .orange.opacity(0.8)
        case 80..<110:
            return .yellow.opacity(0.8)
        case 110..<140:
            return .green.opacity(0.8)
        default:
            return .blue.opacity(0.8)
        }
    }
}

