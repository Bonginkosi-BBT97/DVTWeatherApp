//
//  DVTWeatherAppTests.swift
//  DVTWeatherAppTests
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

@testable import DVTWeatherApp
import XCTest

final class DVTWeatherAppTests: XCTestCase {
  let currentWeatherURL =
    "https://api.openweathermap.org/data/2.5/weather?q=London&appid=f77ddc0a24c1b09b6e4f6bd66e3bc0ab&units=metric"
  let cityName = "London"
  let mockURLSession = MockURLSession()

  func testGetCurrentWeather_Success() async throws {
    // GIVEN

    // swiftlint:disable:next non_optional_string_data_conversion
    let jsonData = """
    {
        "coord": {"lon": -0.1257, "lat": 51.5085},
        "weather": [{"id": 802, "main": "Clouds", "description": "scattered clouds", "icon": "03d"}],
        "main": {"temp": 14.75, "feels_like": 13.98, "temp_min": 11.83, "temp_max": 16.67, "pressure": 1013, "humidity": 65},
        "name": "London",
        "wind": {"speed": 5.66, "deg": 320}
    }
    """.data(using: .utf8)!
   
    let weatherAPIService = WeatherAPIService(session: mockURLSession)
    let urlResponse = HTTPURLResponse(
      url: URL(string: currentWeatherURL)!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )

    mockURLSession.data = jsonData
    mockURLSession.response = urlResponse

    // WHEN
    let weather = try await weatherAPIService.getCurrentWeather(city: cityName)
    // THEN
    XCTAssertEqual(weather.name, cityName)
    XCTAssertEqual(weather.main.temp, 14.75)
    XCTAssertEqual(weather.weather.first?.description, "scattered clouds")
  }

  func testGetCurrentWeather_Error() async throws {
    // GIVEN
    let urlResponse = HTTPURLResponse(
      url: URL(string: currentWeatherURL)!,
      statusCode: 404,
      httpVersion: nil,
      headerFields: nil
    )

    mockURLSession.response = urlResponse

    let weatherAPIService = WeatherAPIService(session: mockURLSession)
    // WHEN / THEN

    do {
      _ = try await weatherAPIService.getCurrentWeather(city: cityName)
      XCTFail("Expected an error but got a success")
    } catch let WeatherAPIError.failedRequest(statuscode) {
      XCTAssertEqual(statuscode, 404)
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }

  func testGetCurrentWeather_InvalidData() async throws {
    // GIVEN
    // swiftlint:disable:next non_optional_string_data_conversion
    let jsonData = "invalid json".data(using: .utf8)!

    let urlResponse = HTTPURLResponse(
      url: URL(string: currentWeatherURL)!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )
    mockURLSession.data = jsonData
    mockURLSession.response = urlResponse

    let weatherAPIService = WeatherAPIService(session: mockURLSession)

    // WHEN/THEN

    do {
      _ = try await weatherAPIService.getCurrentWeather(city: cityName)
    } catch WeatherAPIError.invalidData {
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
}
