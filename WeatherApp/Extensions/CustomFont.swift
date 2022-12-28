//
//  CustomFont.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import UIKit

extension UIFont {
    enum FontWeight: String {
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        case extraBold = "ExtraBold"
         
    }
    
    static func montserrat(size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        guard let customFont = UIFont(name: "MontserratRoman-\(weight.rawValue)", size: size) else {            
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
