//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import Foundation

protocol WeatherServiceable {
//    func getForecast(lat: String, lon: String) async -> Result<TopRated, RequestError>
    func getCurrentWeather(lat: String, lon: String) async -> Result<WeatherData, RequestError>
}

struct WeatherService: HTTPClient, WeatherServiceable {
    func getForecast(lat: String, lon: String) async -> Result<Forecast, RequestError> {
        return await sendRequest(endpoint: WeatherEndpoint.fiveDayForecast(lat: lat, lon: lon), responseModel: Forecast.self)
    }
    
    func getCurrentWeather(lat: String, lon: String) async -> Result<WeatherData, RequestError> {
        return await sendRequest(endpoint: WeatherEndpoint.weather(lat: lat, lon: lon), responseModel: WeatherData.self)
    }
}
