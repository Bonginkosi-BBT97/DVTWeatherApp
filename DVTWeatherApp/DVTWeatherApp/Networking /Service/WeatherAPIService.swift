//
//  WeatherAPIService.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import CoreLocation
import Foundation

class WeatherAPIService {
  private let session: URLSessionProtocol
  private let apiToken = "f77ddc0a24c1b09b6e4f6bd66e3bc0ab"
  private let baseURL = "https://api.openweathermap.org/data/2.5/"
  private let units = "units=metric"

  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }

  // MARK: Get Current Weather

  func getCurrentWeather(city: String) async throws -> CurrentWeatherResponse {
    guard let url = URL(string: "\(baseURL)weather?q=\(city)&appid=\(apiToken)&\(units)")
    else {
      fatalError("the URL is missing")
    }
    return try await fetchCurrentWeatherData(from: url)
  }

  func getCurrentWeatherByCoordinates(
    lat: CLLocationDegrees,
    lon: CLLocationDegrees
  ) async throws -> CurrentWeatherResponse {
    guard let url = URL(string: "\(baseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(apiToken)&\(units)")
    else {
      fatalError("Missing URL")
    }
    return try await fetchCurrentWeatherData(from: url)
  }

  // MARK: Get 5 days Weather Forecast

  func getWeatherForecast(city: String) async throws -> WeatherForecastResponse {
    guard let url = URL(string: "\(baseURL)forecast?q=\(city)&appid=\(apiToken)&\(units)")
    else {
      fatalError("the URL is missing")
    }
    return try await fetchWeatherForecastData(from: url)
  }

  func getWeatherForecastByCoordinates(
    lat: CLLocationDegrees,
    lon: CLLocationDegrees
  ) async throws -> WeatherForecastResponse {
    guard let url = URL(string: "\(baseURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(apiToken)&\(units)")
    else {
      fatalError("Missing URL")
    }
    return try await fetchWeatherForecastData(from: url)
  }
}

extension WeatherAPIService {
  private func fetchCurrentWeatherData(from url: URL) async throws -> CurrentWeatherResponse {
    let urlRequest = URLRequest(url: url)

    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw WeatherAPIError.invalidResponse
    }

    guard httpResponse.statusCode == 200 else {
      throw WeatherAPIError.failedRequest(statusCode: httpResponse.statusCode)
    }
    do {
      let decodedData = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
      return decodedData
    } catch {
      throw WeatherAPIError.invalidData
    }
  }

  private func fetchWeatherForecastData(from url: URL) async throws -> WeatherForecastResponse {
    let urlRequest = URLRequest(url: url)

    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw WeatherAPIError.invalidResponse
    }

    guard httpResponse.statusCode == 200 else {
      throw WeatherAPIError.failedRequest(statusCode: httpResponse.statusCode)
    }
    do {
      let decodedData = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
      return decodedData
    } catch {
      throw WeatherAPIError.invalidData
    }
  }
}
