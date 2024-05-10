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
    let types: [TypeElement]
}


// MARK: - Pokemon Type

struct TypeElement: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct Species: Codable {
    let captureRate: Int
    let color: PokemonColor
    let flavorTextEntries: [FlavorTextEntries]
    
    enum CodingKeys: String, CodingKey {
        case captureRate = "capture_rate"
        case flavorTextEntries = "flavor_text_entries"
        case color
    }
    
    static let sampleSpecies = Species(captureRate: 123, color: PokemonColor.init(name: "white"), flavorTextEntries: [FlavorTextEntries.init(flavorText: "text")] )
}

struct PokemonColor: Codable {
    let name: String
}

struct FlavorTextEntries: Codable {
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}


//enum PokemonType: String, Codable, Identifiable {
//    
//    var id: String { rawValue }
//    
//    case grass
//    case fire
//    case water
//    case bug
//    case normal
//    case dark
//    case poison
//    case electric
//    case ice
//    case fairy
//    case ground
//    case fighting
//    case psychic
//    case rock
//    case ghost
//    case dragon
//    case steel
//    case flying
//}


