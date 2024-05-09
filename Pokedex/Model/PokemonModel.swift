//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
        
    static var samplePokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
}

struct Types: Codable {
    struct `Type`: Codable {
        var name: String
    }
    
    var type: Type
}

struct PokemonInfo {
    var types = [Types]()
}


enum PokemonType: String, Codable, Identifiable {
    
    var id: String { rawValue }
    
    case grass
    case fire
    case water
    case bug
    case normal
    case dark
    case poison
    case electric
    case ice
    case fairy
    case ground
    case fighting
    case psychic
    case rock
    case ghost
    case dragon
    case steel
    case flying
}
