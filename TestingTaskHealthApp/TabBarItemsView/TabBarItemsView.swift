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
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = .gray
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    var body: some View {
        TabView {
            
                MainView()
            
                .tabItem {
                    Image("House")
                    Text("Главная")
                }
            NavigationStack {
                CalendarView()
            }
            
                .tabItem {
                    Image("Calendar")
                    Text("Приёмы")
                }
            NavigationStack {
                ChatView()
            }
            
                .tabItem {
                    Image("Chat")
                    Text("Чат")
                }
            NavigationStack {
                ProfileView()
            }
            
                .tabItem {
                    Image("Profile")
                    Text("Профиль")
                }
        }
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


