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
  @State var currentMinTemperature: String
  @State var currentMaxTemperature: String
  @State var currentWeatherDescription: String

  @State var backgroundImageName: String
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
      homeTabViewModel.fetchWeather(for: locationManager.location)
      homeTabViewModel.$weather
        .sink { weather in
          if let currentWeather = weather {
            currentTemperature = homeTabViewModel.roundTemperatureString(from: currentWeather.main.temp)

            let weatherDescription = WeatherDescription(
              description: currentWeather.weather.first?
                .main ?? ""
            )

            let backgroundImage = BackgroundImageName(description: weatherDescription)
            backgroundImageName = backgroundImage.rawValue

            currentWeatherDescription = weatherDescription.rawValue

            currentMinTemperature = homeTabViewModel
              .roundTemperatureString(from: currentWeather.main.tempMin)
            currentMaxTemperature = homeTabViewModel
              .roundTemperatureString(from: currentWeather.main.tempMax)

            print("Weather description: \(currentWeather.weather.first?.main ?? "")")
            print("Background image name: \(backgroundImageName)")
          }
        }
        .store(in: &cancellables)
    }
  }
}

// #Preview {
//  HomeTabView(
//    locationManager: EnvironmentObject<LocationManager>,
//    homeTabViewModel: HomeTabViewModel(),
//    currentTemperature:  "25",
//    currentMinTemperature: "19",
//    currentMaxTemperature:"30",
//    currentWeatherDescription:"SUNNY" ,
//    backgroundImageName:"sunny"
//    , backgroundColor:  Color.green
//  )
//
// }
