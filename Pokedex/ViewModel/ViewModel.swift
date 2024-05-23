//
//  ViewModel.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    @Published var species: Species?
        
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0, types: [TypeElement.init(slot: 0, type: PokemonType.init(name: "none"))], stats: [Stats.init(baseStat: 0, stat: Stat.init(name: "none"))] )
      
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func getSpecies(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.species = Species(captureRate: 0, color: PokemonColor.init(name: "white"), flavorTextEntries: [FlavorTextEntries.init(flavorText: "test")])
        
        pokemonManager.getPokemonSpecies(id: id) { data in
            DispatchQueue.main.async {
                self.species = data
            }
        }
    }
    
    func formatHeightWeight(value: Int) -> String {
        let doubleValue = Double(value)
        let string = String(format: "%.2f", doubleValue / 10)
        
        return string
    }
}
