//
//  TestingTaskHealthAppApp.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/25/24.
//

import SwiftUI

@main
struct TestingTaskHealthAppApp: App {
    @State private var path = NavigationPath()
    var body: some Scene {
        WindowGroup {
            TabBarItemsView()
            
//            NavigationStack(path: $path) {
////                TabBarItemsView(path: $path)
////                    .navigationDestination(for: <#T##Hashable.Type#>, destination: <#T##(Hashable) -> View#>)
//            }
        }
    }
}

//@main
//struct MyApp: App {
//    @State private var path = NavigationPath()
//    
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack(path: $path) {
//                DoctorListView(path: $path)
//                    .navigationDestination(for: Pages.self) { page in
//                        switch page {
//                        case .doctorCard(let doctor):
//                            DoctorDetailView(doctor: doctor, path: $path)
//                        case .services(let doctor):
//                            ServicesView(doctor: doctor)
//                        }
//                    }
//            }
//        }
//    }
//}

//enum Pages: Hashable {
//    case doctorCard(Doctor)
//    case services(Doctor)
//}
//
