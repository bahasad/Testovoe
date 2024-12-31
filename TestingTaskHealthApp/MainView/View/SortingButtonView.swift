//
//  SortingButtonView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI

struct SortingButtonView: View {
    
    @ObservedObject var viewModel: MainViewModel
    let option: SortOption
    
    var body: some View {
        Button(action: {
            print("Selected Sort Option: \(option.title)")
            if viewModel.selectedSortOption == option {
                viewModel.isDescending.toggle()
                print("Toggled isDescending: \(viewModel.isDescending)")
            } else {
                viewModel.selectedSortOption = option
                viewModel.isDescending = true
                print("Changed to new Sort Option: \(viewModel.selectedSortOption.title)")
            }
            viewModel.sort(by: option)
        }) {
            buttonContent
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(viewModel.selectedSortOption == option ? .appColorRed : Color.clear)
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private var buttonContent: some View {
        HStack(spacing: 4) {
            Text(option.title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(viewModel.selectedSortOption == option ? .appColorWhite : .appColorGray)
            
            if viewModel.selectedSortOption == option {
                Image(systemName: viewModel.isDescending ? "arrow.down" : "arrow.up")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
        }
    }
}
