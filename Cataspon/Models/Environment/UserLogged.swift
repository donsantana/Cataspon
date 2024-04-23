//
//  UserLogged.swift
//  Cataspon
//
//  Created by Done Santana on 4/20/24.
//

import Foundation

enum UserType: String {
    case influencer = "Influencer"
    case guest = "Guest"
}

class UserLogged: ObservableObject {
    @Published var userType: UserType = .guest
}
