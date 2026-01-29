//
//  DetailView.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/27/26.
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(red: 0/255, green: 50/255, blue: 100/255),
                Color(.cyan)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 3) {
                Text(creature.name.capitalized)
                    .font(Font.custom("Avenir Next Condensed", size: 60))
                    .bold()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundStyle(.white)

                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                HStack {
                    AsyncImage(url: URL(string: creatureDetail.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .background(.white)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8, x: 5, y: 5)
                            .overlay{
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                            .padding(.trailing)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    
                    VStack (alignment: .leading){
                        HStack(alignment: .top){
                            Text("Height:")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                            Text(String(format: "%.1f", creatureDetail.height))
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)

                        }
                        HStack(alignment: .top){
                            Text("Weight:")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                            Text(String(format: "%.1f", creatureDetail.weight))
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)

                        }
                    }
                }
                Spacer()
                
            }
            .task {
                creatureDetail.urlString = creature.url
                await creatureDetail.getData()
            }
            .padding()
        }
    }
}

#Preview {
    DetailView(creature: Creature(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
