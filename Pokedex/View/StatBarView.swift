//
//  StatBarView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 5/21/24.
//

import SwiftUI

struct StatBarView: View {
    
    let statName: String
    let statValue: Int
    let maxStatValue: Int
    let screenBoundsWidth: CGFloat
    let pokemonColor: Color
    let leadingAndTrailingPadding: CGFloat = 32
    let statBarHeight: CGFloat = 24
    let statBarCornerRadius: CGFloat = 10
    
    var barWidth: CGFloat {
        CGFloat(statValue) / CGFloat(maxStatValue) * (screenBoundsWidth - leadingAndTrailingPadding)
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
                // Background rectangle bar for the max stat value
                Rectangle()
                    .frame(width: screenBoundsWidth - 32, height: statBarHeight)
                    .foregroundColor(Color(.systemGray6))
                    .cornerRadius(statBarCornerRadius)
                // Foreground rectangle bar
                Rectangle()
                    .frame(width: barWidth, height: statBarHeight)
                    .foregroundColor(pokemonColor)
                    .cornerRadius(statBarCornerRadius)
                // Text showing the stat value
                Text("\(Int(statValue))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(pokemonColor)
                    .padding(.leading, barWidth + 5) // Adjust padding to position the text to the right of the stat bar
            }
        }
        .padding(.vertical, 0)
        .cornerRadius(10)
    }
}

#Preview {
    StatBarView(statName: "HP", statValue: 100, maxStatValue: 1000, screenBoundsWidth: UIScreen.main.bounds.width, pokemonColor: .green)
}
