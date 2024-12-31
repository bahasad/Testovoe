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
                        // User Avatar and Name
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
                        .padding(.bottom, 16)
                        
                        
                        VStack(spacing: 10) {
                            SpecializationView(userText: "Опыт работы: \(user.seniority ?? 0) лет", image: "timeout")
                            SpecializationView(userText:  user.scientificDegreeLabel ?? "", image: "aidkit")
                            SpecializationView(userText: user.higherEducation?.first?.university ?? "", image: "graduation")
                            SpecializationView(userText: user.workExperience?.first?.organization ?? "", image: "location")
                        }
                        
                        
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
                        
                        Text("Проводит диагностику и лечение терапевтических\nбольных. Осуществляет расшифровку и снятие ЭКГ.\nДает рекомендации по диетологии. Доктор имеет\nопыт работы в России и зарубежом. Проводит\nконсультации пациентов на английском языке.")
                            .lineSpacing(6)
                            .font(.system(size: 14, weight: .light))
                            .padding(.top, 15)
                        
                        Spacer()
                            .frame(minHeight: 138)
                        
                        FreeScheduleBtn(user: user, padding: 0)
                           
                        
 
                    }
                }
               
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Педиатр")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpecializationView: View {
    var userText: String
    var image: String
    var body: some View {
        HStack(spacing: 12) {
            Image(image)
                .font(.system(size: 8))
            
            Text(userText)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.appColorTextGray)
    }
}

