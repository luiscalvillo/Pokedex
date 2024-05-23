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
        
    private var screenBoundsWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var pokemonID: Int {
        vm.pokemonDetails?.id ?? 0
    }
    
    private var pokemonType1: String? {
        vm.pokemonDetails?.types.first?.type.name
    }
    
    private var pokemonType2: String? {
        vm.pokemonDetails?.types.last?.type.name
    }
    
    private var pokemonTypeCount: Int? {
        vm.pokemonDetails?.types.count
    }
    
    private var pokemonGradient: LinearGradient {
        getPokemonBackgroundGradient(type: AllPokemonTypes(rawValue: pokemonType1 ?? "") ?? .bug)
    }
    
    private var pokemonBottomGradient: LinearGradient {
        getPokemonBackgroundGradient(type: AllPokemonTypes(rawValue: pokemonType2 ?? "") ?? .bug)
    }
    
    private var pokemonColor: Color {
        convertPokemonTypeToAColor(type: AllPokemonTypes(rawValue: pokemonType1 ?? "") ?? .bug)
    }
    
    private var pokemonDescription: String {
        vm.species?.flavorTextEntries.first?.flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{0C}", with: " ") ?? ""
    }
    
    private var formattedWeight: String {
        vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0)
    }
    
    private var formattedHeight: String {
        vm.formatHeightWeight(value: vm.pokemonDetails?.height ?? 0)
    }
    
    private var captureRate: Int {
        vm.species?.captureRate ?? 0
    }
    
    let maxStatValue = 1000
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                ZStack {
                    BackgroundCurveShape()
                        .fill(pokemonBottomGradient)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenBoundsWidth + 100)
                    BackgroundCurveShape()
                        .fill(pokemonGradient)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenBoundsWidth + 150)
                        .offset(CGSize(width: 0, height: -150))
                    
                    VStack(alignment: .leading) {
                        
                        // Show Pokemon
                        PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
                        
                        Text("# \(pokemonID)")
                            .font(.title)
                            .padding(.leading, 16)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        // MARK: - Pokemon Type
                        HStack {
                            if pokemonTypeCount == 1{
                                TypeView(pokemonType: pokemonType1 ?? "")
                            } else {
                                TypeView(pokemonType: pokemonType1 ?? "")
                                TypeView(pokemonType: pokemonType2 ?? "")
                            }
                        }
                        
                        // MARK: - Pokemon Description
                        
                        Text(pokemonDescription)
                            .font(.title2)
                            .lineLimit(4)
                            .frame(height: 100)
                        
                        // MARK: - Stats
                        
                        SectionTitleView(title: "Stats")
                        
                        if let stats = vm.pokemonDetails?.stats {
                            
                            // Calculate the sum of all the base stat points
                            let totalBaseStats = stats.reduce(0) { $0 + $1.baseStat }
                            
                            ForEach(stats) { stat in
                                StatBarView(statName: stat.stat.name,
                                            statValue: stat.baseStat,
                                            maxStatValue: maxStatValue,
                                            screenBoundsWidth: screenBoundsWidth,
                                            pokemonColor: pokemonColor)
                            }
                            
                            StatBarView(statName: "Total", statValue: totalBaseStats,
                                        maxStatValue: maxStatValue,
                                        screenBoundsWidth: screenBoundsWidth,
                                        pokemonColor: pokemonColor)
                        }
                        else {
                            Text("No stats available")
                        }
                        
                        // MARK: - Characteristics
                        
                        SectionTitleView(title: "Characteristics")
                        CharacteristicView(title: "Weight", value: formattedWeight, unit: "KG", color: pokemonColor)
                        CharacteristicView(title: "Height", value: formattedHeight, unit: "M", color: pokemonColor)
                        CharacteristicView(title: "Catch Rate", value: "\(captureRate)", color: pokemonColor)
                    }
                    Spacer()
                }
                .padding(16) // leading and trailing screen padding
            }
            .onAppear {
                vm.getDetails(pokemon: pokemon)
                vm.getSpecies(pokemon: pokemon)
            }
        }
        .background(Color(.systemBackground))
        .foregroundColor(Color(.label))
    }
}


#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}


// MARK: - Subviews

struct BackgroundCurveShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.60))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.40))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct SectionTitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
    }
}

struct SectionSubheadingView: View {
    
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .font(.title2)
            .foregroundColor(color)
            .fontWeight(.bold)
    }
}

struct CharacteristicView: View {
    let title: String
    let value: String
    let unit: String?
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionSubheadingView(title: title, color: color)
            Text("\(value) \(unit ?? "")")
                .font(.title3)
        }
    }
    
    init(title: String, value: String, unit: String? = nil, color: Color) {
        self.title = title
        self.value = value
        self.unit = unit
        self.color = color
    }
}
