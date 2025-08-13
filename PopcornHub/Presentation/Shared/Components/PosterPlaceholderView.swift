//
//  PosterPlaceholderView.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import SwiftUI

struct PosterPlaceholderView: View {
    let title: String
    
    var initials: String {
        let words = title.split(separator: " ")
        let chars = words.prefix(2).compactMap { $0.first }.map(String.init)
        return chars.joined()
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack {
                Image(systemName: "film").font(.largeTitle).opacity(0.25)
                Text(initials.uppercased()).font(.title2).bold().opacity(0.5)
            }
        }
        .cornerRadius(8)
    }
}
