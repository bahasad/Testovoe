//
//  FreeScheduleBtnView.swift
//  TestingTaskHealthApp
//
//  Created by Baha Sadyr on 12/31/24.
//

import SwiftUI


struct FreeScheduleBtnView: View {
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
