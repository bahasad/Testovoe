//
//  MainViewModel.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/25/24.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var selectedSortOption: SortOption = .price
    @Published var isDescending: Bool = true
    @Published var usersArray: [User] = [] {
        didSet {
            print("usersArray updated: \(usersArray.count) items")
        }
    }
    
    func sort(by option: SortOption) {
        selectedSortOption = option
        print("Sorting by \(option.title), Descending: \(isDescending)")

        switch option {
        case .price:
            if isDescending {
                usersArray.sort { ($0.videoChatPrice ?? 0) > ($1.videoChatPrice ?? 0) }
            } else {
                usersArray.sort { ($0.videoChatPrice ?? 0) < ($1.videoChatPrice ?? 0) }
            }
        case .experience:
            if isDescending {
                usersArray.sort { ($0.seniority ?? 0) > ($1.seniority ?? 0) }
            } else {
                usersArray.sort { ($0.seniority ?? 0) < ($1.seniority ?? 0) }
            }
        case .rating:
            if isDescending {
                usersArray.sort { ($0.ratingsRating ?? 0) > ($1.ratingsRating ?? 0) }
            } else {
                usersArray.sort { ($0.ratingsRating ?? 0) < ($1.ratingsRating ?? 0) }
            }
        }

        print("Sorted Users: \(usersArray.map { $0.ratingsRating ?? 0 })")
    }

    
    
    func loadUsersFromJSON() {
        let dataManager = DataManager()
        if let data = dataManager.loadUsersFromJSON(){
            DispatchQueue.main.async {
                print("Loaded Users: \(self.usersArray.count)")
                self.usersArray = data
            }
        }else {
            print("No users loaded")
        }
        
    }
}


enum SortOption: CaseIterable {
    case price
    case experience
    case rating
    
    var title: String {
        switch self {
        case .price: return "По цене"
        case .experience: return "По стажу"
        case .rating: return "По рейтингу"
            
        }
    }
}


