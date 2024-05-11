//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State private var showDetailView: Bool = true
    
    let pokemon: Pokemon

    var body: some View {
        
        VStack {
            Text("# \(vm.pokemonDetails?.id ?? 0)")
                .font(.title)
            PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
           
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("\(vm.pokemonDetails?.types.first?.type.name.uppercased() ?? "")")
                                .font(.title3)
                                .padding(8)
                                .frame(width: 100, height: 40)
                                .background(.gray)
                                .cornerRadius(20)
                            Text("\(vm.pokemonDetails?.types.first?.type.name.uppercased() ?? "")")
                                .font(.title3)
                                .padding(8)
                                .frame(width: 100, height: 40)
                                .background(.gray)
                                .cornerRadius(20)
                        }
                        
                    Text("\(vm.species?.flavorTextEntries.first?.flavorText.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{0C}", with: " ") ?? "")")
                            .font(.title2)
                            .lineLimit(4)
                            .frame(height: 100)
                        
                        Text("Weight")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0)) KG")
                            .font(.title)
                        
                        Text("Height")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.height ?? 0)) M")
                            .font(.title)
                
                        Text("Catch Rate")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(vm.species?.captureRate ?? 0)")
                            .font(.title)
                    }
                
                Spacer()
            }
            .padding(16)
                
            }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
            vm.getSpecies(pokemon: pokemon)
        }
    }
}


#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}
