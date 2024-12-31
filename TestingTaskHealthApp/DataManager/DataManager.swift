//
//  DataManager.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/25/24.
//

import Foundation

class DataManager {

    func loadUsersFromJSON() -> [User]? {
        guard let url = Bundle.main.url(forResource: "jsonForUser", withExtension: "json") else {
            print("Failed to locate users.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let welcome = try decoder.decode(Welcome.self, from: data)
            return welcome.record?.data?.users
        } catch {
            print("Failed to load or decode JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
                                                         
