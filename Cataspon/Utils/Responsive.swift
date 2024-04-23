//
//  Responsive.swift
//  Cataspon
//
//  Created by Done Santana on 4/12/24.
//

import Foundation
import UIKit

struct Responsive {
    static let shared = Responsive()
    var width, height, inch: Double
    
    init() {
     let size = UIScreen.main.bounds
     width = Double(size.width)
     height = Double(size.height)

     // c2 = a2+b2
     inch = sqrt(pow(width, 2)+pow(height, 2))
   }

   //width percent value
    func widthPercent(percent: Double) -> Double{
     return Double(width * percent / 100)
   }

   //height percent value
    func heightPercent(percent: Double) -> Double{
     return Double(height * percent / 100)
   }

   //inch percent value
    func inchPercent(percent: Double) -> Double{
     return Double(inch * percent / 100)
   }
    
    //width percent value
     func widthFloatPercent(percent: Double) -> CGFloat{
      return CGFloat(width * percent / 100)
    }

    //height percent value
     func heightFloatPercent(percent: Double) -> CGFloat{
      return CGFloat(height * percent / 100)
    }
    
    func paddingBtwElement(elementWidth: Double, elementCount: Int)->CGFloat{
      return CGFloat(width - (elementWidth * Double(elementCount))) / (CGFloat(elementCount) + 1.0)
    }

}
