//
//  WeatherAPIError.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import Foundation

enum WeatherAPIError: Error {
  case invalidResponse
  case failedRequest(statusCode: Int)
  case invalidData
}
