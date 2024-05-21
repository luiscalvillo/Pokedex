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
    
    private var pokemonType1: String? {
        vm.pokemonDetails?.types.first?.type.name
    }
    
    private var pokemonType2: String? {
        vm.pokemonDetails?.types.first?.type.name
    }
    
    private var pokemonTypeCount: Int? {
        vm.pokemonDetails?.types.count
    }
    
    private var pokemonGradient: LinearGradient {
        getPokemonBackgroundGradient(type: pokemonType1 ?? "")
    }
    
    private var pokemonColor: Color {
        convertPokemonTypeToAColor(type: pokemonType1 ?? "")
    }
    
    let maxStatValue = 1000
    let pokemonTypeHeight: CGFloat = 40
    let pokemonTypeWidth: CGFloat = 140

    
    var body: some View {
        
        ScrollView {
            VStack {
                ZStack {
                    BackgroundCurveShape()
                        .fill(pokemonGradient)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenBoundsWidth)
                    
                    VStack(alignment: .leading) {
                        
                        PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
                        
                        Text("# \(vm.pokemonDetails?.id ?? 0)")
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
                                TypeView(pokemonTypeWidth: pokemonTypeWidth, pokemonTypeHeight: pokemonTypeHeight, pokemonType: pokemonType1 ?? "")
                            } else {
                                TypeView(pokemonTypeWidth: pokemonTypeWidth, pokemonTypeHeight: pokemonTypeHeight, pokemonType: pokemonType1 ?? "")
                                TypeView(pokemonTypeWidth: pokemonTypeWidth, pokemonTypeHeight: pokemonTypeHeight, pokemonType: pokemonType2 ?? "")
                            }
                        }
                        
                        // MARK: - Pokemon Description
                        
                        Text("\(vm.species?.flavorTextEntries.first?.flavorText.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{0C}", with: " ") ?? "")")
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
                                            maxValue: maxStatValue,
                                            screenBounds: screenBoundsWidth,
                                            pokemonColor: pokemonColor)
                            }
                            
                            StatBarView(statName: "Total", statValue: totalBaseStats,
                                        maxValue: maxStatValue,
                                        screenBounds: screenBoundsWidth,
                                        pokemonColor: pokemonColor)
                        }
                        else {
                            Text("No stats available")
                        }
                        
                        // MARK: - Characteristics
                        
                        SectionTitleView(title: "Characteristics")
                        CharacteristicView(title: "Weight", value: vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0), unit: "KG", color: pokemonColor)
                        CharacteristicView(title: "Height", value: vm.formatHeightWeight(value: vm.pokemonDetails?.height ?? 0), unit: "M", color: pokemonColor)
                        CharacteristicView(title: "Catch Rate", value: "\(vm.species?.captureRate ?? 0)", color: pokemonColor)
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


struct TypeView: View {
    
    let pokemonTypeWidth: CGFloat
    let pokemonTypeHeight: CGFloat
    let pokemonType: String
    
    var body: some View {
        Text("\(pokemonType.uppercased())")
            .font(.title3)
            .foregroundStyle(.white)
            .padding(8)
            .frame(width: pokemonTypeWidth, height: pokemonTypeHeight)
            .background(convertPokemonTypeToAColor(type: pokemonType))
            .cornerRadius(20)
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

struct StatBarView: View {
    
    let statName: String
    let statValue: Int
    let maxValue: Int
    let screenBounds: CGFloat
    let pokemonColor: Color
    let leadingAndTrailingPadding: CGFloat = 32
    
    var barWidth: CGFloat {
        CGFloat(statValue) / CGFloat(maxValue) * (screenBounds - leadingAndTrailingPadding)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(statName.uppercased())
                    .frame(width: 250, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
            }
            ZStack(alignment: .leading) {
                // Background rectangle bar for the max value
                Rectangle()
                    .frame(width: screenBounds - 32, height: 24)
                    .foregroundColor(Color(.systemGray6))
                    .cornerRadius(10)
                // Foreground rectangle bar
                Rectangle()
                    .frame(width: barWidth, height: 24)
                    .foregroundColor(pokemonColor)
                    .cornerRadius(10)
                // Text showing the stat value
                Text("\(Int(statValue))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(pokemonColor)
                    .padding(.leading, barWidth + 5) // Adjust the padding to position the text after the blue bar
            }
        }
        .padding(.vertical, 0)
        .cornerRadius(10)
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
