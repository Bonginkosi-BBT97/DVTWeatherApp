//
//  WeatherAPIService.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import Foundation

class WeatherAPIService {
  private let session: URLSessionProtocol
  private let apiToken = "f77ddc0a24c1b09b6e4f6bd66e3bc0ab"
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }

  func getCurrentWeather(city: String) async throws -> ResponseBody {
    guard let url =
      URL(
        string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiToken)&units=metric"
      )
    else {
      fatalError("the URL is missing")
    }

    let urlRequest = URLRequest(url: url)

    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw WeatherAPIError.invalidResponse
    }

    guard httpResponse.statusCode == 200 else {
      throw WeatherAPIError.failedRequest(statusCode: httpResponse.statusCode)
    }
    do {
      let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
      return decodedData
    } catch {
      throw WeatherAPIError.invalidData
    }
  }
}
