//
//  DetailsView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/26/24.
//


import SwiftUI

struct DetailsView: View {
    var users: [User]
    
    var body: some View {
        ZStack {
            Color.appColorBackGray.ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let user = users.first {
                        userHeader(user)
                            .padding(.bottom, 16)
                        userDetails(user)
                        serviceCost(user)
                        descriptionText()
                        Spacer()
                            .frame(minHeight: 138)
                        scheduleButton(user)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Педиатр")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func userHeader(_ user: User) -> some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: user.avatar ?? ""))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.lastName ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\((user.firstName ?? "") + " " + (user.patronymic ?? ""))")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func userDetails(_ user: User) -> some View {
        VStack(spacing: 10) {
            SpecializationView(userText: "Опыт работы: \(user.seniority ?? 0) лет", image: "timeout")
            SpecializationView(userText: user.scientificDegreeLabel ?? "", image: "aidkit")
            SpecializationView(userText: user.higherEducation?.first?.university ?? "", image: "graduation")
            SpecializationView(userText: user.workExperience?.first?.organization ?? "", image: "location")
        }
    }
    
    private func serviceCost(_ user: User) -> some View {
        HStack(spacing: 12) {
            Text("Стоимость услуг")
                .font(.subheadline)
                .bold()
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
    
    private func descriptionText() -> some View {
        Text("Проводит диагностику и лечение терапевтических больных. Осуществляет расшифровку и снятие ЭКГ. Дает рекомендации по диетологии. Доктор имеет опыт работы в России и за рубежом. Проводит консультации пациентов на английском языке.")
            .lineSpacing(6)
            .font(.system(size: 14, weight: .light))
            .padding(.top, 15)
    }
    
    private func scheduleButton(_ user: User) -> some View {
        if let freeReceptionTime = user.freeReceptionTime, freeReceptionTime.isEmpty {
            return AnyView(
                Text("Нет свободного расписания")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 47)
                    .background(Color.appColorGrayForDisabledBtn)
                    .cornerRadius(8)
                    .padding(.horizontal, 0)
            )
        } else {
            return AnyView(
                NavigationLink(destination: PricesView(users: user)) {
                    Text("Записаться")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 47)
                        .background(Color.appColorRed)
                        .cornerRadius(8)
                        .padding(.horizontal, 0)
                }
                    .buttonStyle(PlainButtonStyle())
            )
        }
    }
}
