//
//  Weather.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import Foundation

struct WeatherData: Codable {
    let dt: Int
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    
    var humidityDescription: String {
        return "\(humidity)%"
    }
    
    var tempDescription: String {
        return "\(String(format: "%.1f", temp)) °C"
    }
}

struct Wind: Codable {
    let speed: Double
    
    var speedDescription: String {
        return "\(String(format: "%.1f", speed)) km/h"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
        
    var imageName: String {
        var imageName: String = ""
        switch id {
        case 200...232:
            imageName = "cloud_bolt"
        case 300...321:
            imageName = "cloud_drizzle"
        case 500...531:
            imageName = "cloud_rain"
        case 600...622:
            imageName = "cloud_snow"
        case 701...781:
            imageName = "cloud_fog"
        case 800:
            
            let hour = Calendar.current.component(.hour, from: Date())
            if hour < 18 && hour > 6 {
                imageName = "sun_max"
            }
            else{
                imageName = "moon_max"
            }
            
        case 801...804:
            imageName = "cloud_bolt"
        default:
            imageName = "cloud"
        }
        
        return imageName
    }
}

