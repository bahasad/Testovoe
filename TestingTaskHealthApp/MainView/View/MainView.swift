//
//  MainView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/25/24.
//

import SwiftUI

struct MainView: View {
    
    @State var path = NavigationPath()
    @StateObject var viewModel = MainViewModel()
    @State private var hasLoaded = false
    let column = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                VStack(alignment: .leading, spacing: 16) {
                    SortingButtonGroupView(viewModel: viewModel)
                        .padding(.horizontal, 16)
                    
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredUsers) { user in
                                NavigationLink(destination: DetailsView(users: [user])) {
                                    CardView(user: user)
                                        .padding(.vertical, 8)
                                        .background(Color.clear)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(PlainButtonStyle()) 
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .background(Color.appColorBackGray.ignoresSafeArea(.all))
                .navigationTitle("Педиатры")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .automatic)
                .onAppear {
                    if !hasLoaded {
                        viewModel.loadUsersFromJSON()
                        hasLoaded = true
                    }
                }
            }
        }
    }
}









#Preview {
    MainView()
}


