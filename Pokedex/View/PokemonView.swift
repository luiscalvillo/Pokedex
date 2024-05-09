//
//  PokemonView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @Binding var showDetailView: Bool
    
    let pokemon: Pokemon
    let dimensions: Double = 140
    let detailViewDimensions: Double = 300
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
            }
            .background(.thinMaterial)
            .clipShape(Circle())
            
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    PokemonView(showDetailView: .constant(false), pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
}
