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

struct CardView: View {
    var user: User
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: URL(string: user.avatar ?? ""))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.lastName ?? "")
                        .font(.system(size: 16, weight: .bold))
                    
                    Text("\((user.firstName ?? "") + " " + (user.patronymic ?? ""))")
                        .font(.system(size: 16, weight: .regular))
                    
                    if let rating = user.ratingsRating {
                        StarView(rating: rating)
                    } else {
                        Text("Нет данных о рейтинге")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Text("\((user.specialization?.first?.name ?? "Специализация не указана")) • стаж \(user.seniority ?? 0) лет")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.gray)
                    
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
            .padding(.horizontal, 16)
 
            FreeScheduleBtn(user: user, padding: 16)
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appColorGray, lineWidth: 1)
        )
        .padding(.horizontal, 0)
    }
}

struct FreeScheduleBtn: View {
    var user: User
    var padding: CGFloat?
    var body: some View {
        if let freeReceptionTime = user.freeReceptionTime, freeReceptionTime.isEmpty {
            Text("Нет свободного расписания")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 47)
                .background(Color.appColorGrayForDisabledBtn)
                .cornerRadius(8)
                .padding(.horizontal, padding)
        } else {
            Text("Записаться")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 47)
                .background(Color.appColorRed)
                .cornerRadius(8)
                .padding(.horizontal, padding)
        }
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


