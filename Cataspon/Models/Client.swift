//
//  Client.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import Foundation

struct Client: Codable {
    let id, name: String
    let sponsors: [String]
    let contactInformation: ContactInformation
    
    static let allMockClients: [Client] = Bundle.main.decode(file: "clients.json")
    static let sampleClient: Client = allMockClients[0]
    
    func getSponsors() -> [Sponsor] {
        return Sponsor.allMockSponsors.filter({sponsors.contains($0.id)})
    }
}
