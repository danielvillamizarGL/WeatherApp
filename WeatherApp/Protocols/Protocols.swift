//
//  Protocols.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import Foundation

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}


protocol AddCityDelegate {
    func changeCity(city: CityModel)
}
