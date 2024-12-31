//
//  PricesView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI

struct PricesView: View {
    var users: User
    
    var body: some View {
        ZStack {
            Color.appColorBackGray.ignoresSafeArea(.all)
            VStack(spacing: 24) {
                
                VStack(spacing: 12) {
                    TextView(text: "Видеоконсультация")
                    serviceCost(users, min: "30 мин")
                }
                .padding(.top, 15)
                VStack(spacing: 12) {
                    TextView(text: "Чат с врачом")
                    serviceCost(users, min: "30 мин")
                }
                VStack(spacing: 12) {
                    TextView(text: "Приём в клинике")
                    serviceCost(users, min: "В клинике")
                }
                Spacer()
                
            }
            .navigationTitle("Стоимость услуг")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
            Spacer()
        }
        
    }
    
    private func serviceCost(_ user: User, min: String) -> some View {
        HStack(spacing: 100) {
            Text(min)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            if let price = user.videoChatPrice {
                Text("от \(price) ₽")
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            } else {
                Text("Price: Not specified")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}
