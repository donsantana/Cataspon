//
//  Client.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import Foundation

struct Client: Decodable {
    var id, name: String
    var contactInformation: ContactInformation
}
