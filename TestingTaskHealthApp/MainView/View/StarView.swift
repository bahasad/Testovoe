//
//  StarView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI


struct StarView: View {
    var rating: Double
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= Int(rating.rounded(.down)) ? "star.fill" : "star")
                    .foregroundColor(index <= Int(rating.rounded(.down)) ? Color.appColorRed : Color.appColorGray)
                    .font(.system(size: 10))
            }
        }
    }
}

