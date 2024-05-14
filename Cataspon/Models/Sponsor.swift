//
//  Sponsor.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import Foundation
import UIKit


struct Sponsor: Decodable {
    var id, name, description: String
    var contactInformation: ContactInformation
    
    static let allMockSponsors: [Sponsor] = Bundle.main.decode(file: "sponsors.json")
    static let sampleSponsor: Sponsor = allMockSponsors[0]
    
    func getImage() -> UIImage {
        return UIImage(named: contactInformation.logoURL)!
    }
    
    func sponsorsOf() {
        
    }
}
