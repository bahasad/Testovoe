//
//  SpecializationView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI

struct SpecializationView: View {
    var userText: String
    var image: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .font(.system(size: 16))

            Text(userText)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.appColorTextGray)
    }
}

