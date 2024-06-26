//
//  DVTWeatherAppTests.swift
//  DVTWeatherAppTests
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import CoreData
import CoreLocation
@testable import DVTWeatherApp
import XCTest

final class DVTWeatherAppTests: XCTestCase {
  let currentWeatherURL =
    "https://api.openweathermap.org/data/2.5/weather?q=London&appid=f77ddc0a24c1b09b6e4f6bd66e3bc0ab&units=metric"
  let cityName = "London"
  let mockURLSession = MockURLSession()

  var homeTabViewModel: HomeTabViewModel!
  var favouritesTabViewModel: FavouritesViewModel!

  var container: NSPersistentContainer!

  @MainActor override func setUpWithError() throws {
    homeTabViewModel = HomeTabViewModel()

    container = NSPersistentContainer(name: "FavouritesContainer")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Unable to load persistent stores: \(error)")
      }
    }
    favouritesTabViewModel = FavouritesViewModel()
    favouritesTabViewModel.container = container
  }

  @MainActor override func tearDownWithError() throws {
    homeTabViewModel = nil
    favouritesTabViewModel = nil
    container = nil
  }

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

  // MARK: - - Test For The HomeViewModel --

  // MARK: Current Weather Tests

  @MainActor func testRoundedTemperatureString() throws {
    // GIVEN
    let temperature1 = 16.7
    let temperature2 = 16.5
    let temperature3 = 16.0
    let temperature4 = 16.9
    let temperature5 = 16.2

    // WHEN
    let temperatureResults1 = WeatherUtilities.roundTemperatureString(from: temperature1)
    let temperatureResults2 = WeatherUtilities.roundTemperatureString(from: temperature2)
    let temperatureResults3 = WeatherUtilities.roundTemperatureString(from: temperature3)
    let temperatureResults4 = WeatherUtilities.roundTemperatureString(from: temperature4)
    let temperatureResults5 = WeatherUtilities.roundTemperatureString(from: temperature5)

    // THEN
    XCTAssertEqual(temperatureResults1, "17", "16.7 should round up tp 17")
    XCTAssertEqual(temperatureResults2, "17", "16.5 should round up to 17")
    XCTAssertEqual(temperatureResults3, "16", "16.0 should remain 16")
    XCTAssertEqual(temperatureResults4, "17", "16.9 should round up to 17")
    XCTAssertEqual(temperatureResults5, "16", "16.2 should round down to 16")
  }

  @MainActor func testCoordinatesFromLocation() {
    // GIVEN
    let viewModel = HomeTabViewModel()
    let location = CLLocation(latitude: 40.7128, longitude: -74.0060)

    // WHEN
    if let (lat, lon) = try? viewModel.coordinates(from: location) {
      // THEN
      XCTAssertNotNil(lat)
      XCTAssertNotNil(lon)
      XCTAssertEqual(lat, location.coordinate.latitude)
      XCTAssertEqual(lon, location.coordinate.longitude)
    } else {
      XCTFail("Got nil instead of coordinates")
    }
  }

  @MainActor func testCoordinatesFromNilLocation() {
    // GIVEN
    let viewModel = HomeTabViewModel()

    // WHEN
    if let (lat, lon) = try? viewModel.coordinates(from: nil) {
      // THEN
      XCTAssertEqual(lat, 37.3230)
      XCTAssertEqual(lon, -122.0322)
    } else {
      XCTFail("Got nil instead of coordinates")
    }
  }

  // MARK: Weather Forecast Tests

  @MainActor func testGetDayOfWeek() {
    // GIVE "dt_txt": "2022-08-30 18:00:00"
    let dateStringData = [
      "2024-06-14 00:00:00",
      "2024-06-15 00:00:00",
      "2024-06-16 00:00:00",
      "2024-06-17 00:00:00",
      "2024-06-18 00:00:00"
    ]
    let expectedDaysData = ["Friday", "Saturday", "Sunday", "Monday", "Tuesday"]

    // WHEN
    for (dateString, expectedDays) in zip(dateStringData, expectedDaysData) {
      /// THEN
      XCTAssertEqual(WeatherUtilities.getDayOfWeek(from: dateString), expectedDays)
    }
  }

  // MARK: - - Test For The FavouritesViewModel --

  func testFetchCities() throws {
    // GIVEN
    let city = CityEntity(context: container.viewContext)
    city.name = "Test City"

    // WHEN
    try container.viewContext.save()
    favouritesTabViewModel.fetchCities()

    // THEN
    XCTAssertEqual(favouritesTabViewModel.cities.count, 1)
    XCTAssertEqual(favouritesTabViewModel.cities.first?.name, "Test City")
  }

  func testCityExists() throws {
    // GIVEN
    let city = CityEntity(context: container.viewContext)
    city.name = "Existing City"
    // WHEN
    try container.viewContext.save()
    // THEN
    XCTAssertTrue(favouritesTabViewModel.cityExists(name: "Existing City"))
    XCTAssertFalse(favouritesTabViewModel.cityExists(name: "Nonexistent City"))
  }
}
