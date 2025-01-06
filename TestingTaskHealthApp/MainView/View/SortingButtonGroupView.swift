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
                            .background(option == .rating ? Color.clear : .appColorForStroke)
                            .padding(.vertical, 1),
                        alignment: .trailing
                    )
            }
        }
        .background(Color.appColorForCards)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appColorForStroke, lineWidth: 1)
            
        )
        
        
        .cornerRadius(8)
    }
}

