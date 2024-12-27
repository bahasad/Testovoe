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
            Color.appColorBackround.ignoresSafeArea(.all)
            NavigationStack(path: $path) {
                
                VStack(alignment: .leading, spacing: 16) {
                    SortingButtonGroup(viewModel: viewModel)
                    ScrollView(.vertical, showsIndicators: false ) {
                        VStack( spacing: 16) {
                            if viewModel.usersArray.isEmpty {
                                Text("No users available").foregroundColor(.red)
                            } else {
                                ForEach(viewModel.usersArray) { user in
                                    CardView(user: user)
                                }
                            }
                        }
                    }
                    .simultaneousGesture(TapGesture())
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle("Педиатры")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                .padding(.horizontal, 16)
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

struct CardView: View {
    
    var user: User
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: URL(string: user.avatar ?? ""))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(user.lastName ?? "")
                        .font(.system(size: 16, weight: .bold))
                    HStack(spacing: 4) {
                        let text = (user.firstName ?? "") + " " + (user.patronymic ?? "")
                        Text(text)
                            .font(.system(size: 16, weight: .bold))
                        
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "star")
                            .font(.system(size: 8))
                            .frame(width: 12, height: 12)
                    }
                    HStack(spacing: 2) {
                        if let specialization = user.specialization, let firstSpec = specialization.first?.name {
                            Text(firstSpec)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.gray)
                        } else {
                            Text("Специализация не указана")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.gray)
                        }
                        Text("・")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.gray)
                        if let seniority = user.seniority, seniority >= 0 {
                            Text("стаж \(seniority) лет")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.gray)
                        } else {
                            Text("Стаж не указан")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.gray)
                        }
                    }
                    if let price = user.videoChatPrice {
                        Text("от \(price) ₽")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    } else {
                        Text("Цена не указана")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    
                    
                }
                .padding(.top, 10)
                Spacer()
                Image(systemName: "heart")
                    .foregroundStyle(.appColorGray)
                    .frame(width: 24, height: 24)
                
            }
            .padding(.horizontal, 0)
            .padding(.top, 20)
            
            if let freeReceptionTime = user.freeReceptionTime, freeReceptionTime.isEmpty {
                Button {
                    
                } label: {
                    Text("Нет свободного расписания")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.black)
                }
                .contentShape(Rectangle())
                .frame(height: 47)
                .frame(maxWidth: .infinity)
                .background(.appColorGrayForDisabledBtn)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                NavigationLink(
                    destination: DetailsView(users: [user])
                ) {
                    Text("Записаться")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.appColorWhite)
                        .frame(height: 47)
                        .frame(maxWidth: .infinity)
                        .background(.appColorRed)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .contentShape(Rectangle())
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appColorGray, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
}


struct SortingButton: View {
    
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

struct SortingButtonGroup: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(SortOption.allCases, id: \.self) { option in
                SortingButton(viewModel: viewModel, option: option)
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




#Preview {
    MainView()
}


