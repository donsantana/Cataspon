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
    
    func getImage() -> UIImage {
        return UIImage(named: contactInformation.logoUrl)!
    }
}
