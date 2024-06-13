//
//  HomeTabView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Combine
import CoreLocation
import SwiftUI

struct HomeTabView: View {
  @EnvironmentObject var locationManager: LocationManager
  @StateObject var homeTabViewModel = HomeTabViewModel()
  @State private var cancellables: Set<AnyCancellable> = []

  @State var currentTemperature: String

  let weatherTitle: String
  let backgroundImageName: String
  let backgroundColor: Color

  var body: some View {
    VStack {
      topSection
      CustomDividerView()
      middleSection
      bottomSection
        .onAppear {}
      Spacer()
    }
    .background(backgroundColor)
    .onAppear {
      homeTabViewModel.fetchWeather(for: locationManager.location!)
      homeTabViewModel.$weather
        .sink { weather in
          if let currentWeather = weather {
            currentTemperature = homeTabViewModel.roundTemperatureString(from: currentWeather.main.temp)
            print("Temperature: \(currentWeather.main.temp)")
            print("Weather: \(currentWeather.weather.first?.description ?? "")")
            print("City Name: \(currentWeather.name)")
          }
        }
        .store(in: &cancellables)
    }
  }
}

#Preview {
  HomeTabView(
    homeTabViewModel: HomeTabViewModel(), currentTemperature: "25",
    weatherTitle: "SUNNY",
    backgroundImageName: "sunny",
    backgroundColor: Color.green
  )
}
