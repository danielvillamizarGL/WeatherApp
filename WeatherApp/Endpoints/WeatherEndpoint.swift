//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import Foundation


enum WeatherEndpoint {
    case fiveDayForecast(lat: String, lon: String)
    case weather(lat: String, lon: String)
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .fiveDayForecast:
            return "/data/2.5/forecast"
        case .weather:
            return "/data/2.5/weather"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .fiveDayForecast(let lat, let lon), .weather(let lat, let lon):
            return [URLQueryItem(name: "lat", value: lat),
                    URLQueryItem(name: "lon", value: lon)]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fiveDayForecast, .weather:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .fiveDayForecast, .weather:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .fiveDayForecast, .weather:
            return nil
        }
    }
}
