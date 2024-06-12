//
//  WeatherForecastModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
//

import Foundation

struct WeatherForecastResponse: Codable {
  let cod: String
  let message: Int
  let cnt: Int
  let list: [Forecast]
  let city: City
}

struct City: Codable {
  let id: Int
  let name: String
  let coord: Coord
  let country: String
  let population: Int?
  let timezone, sunrise, sunset: Int
}

struct Coord: Codable {
  let lat, lon: Double
}

struct Forecast: Codable {
  let dt: Int // swiftlint:disable:this identifier_name
  let main: MainClass
  let weather: [Weather]
  let clouds: Clouds
  let wind: Wind
  let visibility: Int
  let pop: Double
  let sys: Sys
  let dtTxt: String
  let rain: Rain?

  enum CodingKeys: String, CodingKey {
    // swiftlint:disable:next identifier_name
    case dt, main, weather, clouds, wind, visibility, pop, sys
    case dtTxt = "dt_txt"
    case rain
  }
}

struct Clouds: Codable {
  let all: Int
}

struct MainClass: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, humidity: Int
  let seaLevel, grndLevel: Int?
  let tempKf: Double

  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
    case seaLevel = "sea_level"
    case grndLevel = "grnd_level"
    case tempKf = "temp_kf"
  }
}

struct Rain: Codable {
  let the3H: Double?

  enum CodingKeys: String, CodingKey {
    case the3H = "3h"
  }
}

struct Sys: Codable {
  let pod: String
}

struct Weather: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

struct Wind: Codable {
  let speed: Double
  let deg: Int
  let gust: Double?
}
