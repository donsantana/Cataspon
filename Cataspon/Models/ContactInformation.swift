//
//  ContactInformation.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import Foundation


struct ContactInformation: Decodable {
    var id = UUID().uuidString
    var email, phoneNumber, webUrl, logoUrl: String
}
