//
//  Forecast.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import Foundation

struct Forecast: Codable {
    let list: [Data]
    let city: City
}

struct City: Codable {
    let name: String
}


struct Data: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    var dateTimeConversion: String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "d MMM h:mm a"
        
        return dateFormat.string(from: date)
    }
}


