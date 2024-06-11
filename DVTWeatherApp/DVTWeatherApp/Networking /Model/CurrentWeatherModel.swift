//
//  CurrentWeatherModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import Foundation

struct ResponseBody: Decodable {
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

  struct MainResponse: Decodable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
  }

  struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
  }
}

// extension ResponseBody.MainResponse {
//    var feelsLike: Double { return feelsLike }
//    var tempMin: Double { return tempMin }
//    var tempMax: Double { return tempMax }
// }
