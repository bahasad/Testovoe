//
//  CardView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI

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
 
            FreeScheduleBtnView(user: user, padding: 16)
        }
        .padding(.vertical, 8)
        .background(Color.appColorForCards)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appColorForStroke, lineWidth: 1)
        )
        .padding(.horizontal, 0)
    }
}
