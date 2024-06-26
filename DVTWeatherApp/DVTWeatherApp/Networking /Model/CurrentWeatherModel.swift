//
//  CurrentWeatherModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
  var coord: CoordinatesResponse
  var weather: [WeatherResponse]
  var main: MainResponse
  var name: String
  var wind: WindResponse

  struct CoordinatesResponse: Decodable {
    var lon: Double
    var lat: Double
  }

  struct WeatherResponse: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
  }

  // swiftlint:disable identifier_name
  struct MainResponse: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
  }

  // swiftlint:enable identifier_name
  struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
  }
}

extension CurrentWeatherResponse.MainResponse {
  var feelsLike: Double { return feels_like }
  var tempMin: Double { return temp_min }
  var tempMax: Double { return temp_max }
}
