//
//  SortingButtonGroupView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI

struct SortingButtonGroupView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(SortOption.allCases, id: \.self) { option in
                SortingButtonView(viewModel: viewModel, option: option)
                    .overlay(
                        Divider()
                            .background(option == .rating ? Color.clear : .appColorGray)
                            .padding(.vertical, 1),
                        alignment: .trailing
                    )
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appColorGray, lineWidth: 1)
        )
        .cornerRadius(8)
    }
}

