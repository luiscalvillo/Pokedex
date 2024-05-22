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
    let dimensions: Double = 90
    let detailViewDimensions: Double = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack(alignment: showDetailView ? .leading : .center) {
                AsyncImage(url: URL(string: "\(PokemonManager.PokemonSprites.official.rawValue)\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
                } placeholder: {
                    ProgressView()
                        .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
                }
                
                Text("\(pokemon.name.uppercased())")
                    .font(showDetailView ? .largeTitle : .subheadline)
                    .fontWeight(showDetailView ? .black : .bold)
                    .foregroundColor(Color(.label))
                    .padding(.leading, 16)
            }
        }
    }
}

#Preview {
    PokemonView(showDetailView: .constant(false), pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
}
