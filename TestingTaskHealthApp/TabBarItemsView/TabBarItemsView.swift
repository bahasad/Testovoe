//
//  TabBarItemsView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/25/24.
//

import SwiftUI

struct TabBarItemsView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.backgroundColor = .appColorForCards
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
                .accentColor(.appColorRed)
                .foregroundColor(.gray)
            
            NavigationStack {
                CalendarView()
            }
            
            .tabItem {
                Image(systemName: "calendar")
                Text("Приёмы")
            }
            .accentColor(.appColorRed)
            .foregroundColor(.gray)
            
            NavigationStack {
                ChatView()
            }
            
            .tabItem {
                Image(systemName: "bubble.left.fill")
                Text("Чат")
            }
            .accentColor(.appColorRed)
            .foregroundColor(.gray)
            
            NavigationStack {
                ProfileView()
            }
            
            .tabItem {
                Image(systemName: "person.circle.fill")
                Text("Профиль")
            }
            .accentColor(.appColorRed)
            .foregroundColor(.gray)
        }
        .accentColor(.appColorRed)
    }
}

#Preview {
    TabBarItemsView()
}

struct CalendarView: View {
    var body: some View {
        VStack {
            Text("Приёмы")
        }
    }
}
struct ChatView: View {
    var body: some View {
        VStack {
            Text("Чат")
        }
    }
}
struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Профиль")
        }
    }
}


