//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import Foundation

class PokemonManager {
    
    enum PokemonSprites: String {
        case home = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
        case official = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
        case sprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    }
    
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailedPokemon(id: Int, _completion:@escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            _completion(data)
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonSpecies(id: Int, _completion:@escaping (Species) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon-species/\(id)/", model: Species.self) { data in
            _completion(data)
        } failure: { error in
            print(error)
        }
    }
}
