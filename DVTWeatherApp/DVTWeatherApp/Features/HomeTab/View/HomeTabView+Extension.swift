//
//  HomeTabView+Extension.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Foundation
import SwiftUI

extension HomeTabView {
  var topSection: some View {
    ZStack {
      Image(homeTabViewModel.backgroundImageName)
        .resizable()
        .scaledToFit()
        .ignoresSafeArea(.all)

      VStack {
        ZStack(alignment: .topTrailing) {
          Text(homeTabViewModel.currentTemperature)
            .font(.largeTitle)
            .bold()
          Text("°")
            .font(.largeTitle)
            .offset(x: 12, y: -5)
        }
        Text(homeTabViewModel.currentWeatherDescription)
          .font(.largeTitle)
      }
      .foregroundColor(.white)
      .padding(.bottom, 150)
    }
  }

  var middleSection: some View {
    VStack {
      HStack(alignment: .center, spacing: -10) {
        CurrentWeatherCardView(temperatureValue: homeTabViewModel.currentMinTemperature, title: "min")
        Spacer()
        CurrentWeatherCardView(temperatureValue: homeTabViewModel.currentTemperature, title: "Current")
        Spacer()
        CurrentWeatherCardView(temperatureValue: homeTabViewModel.currentMaxTemperature, title: "max")
      }
    }
    .padding(.top, -80)
  }

  var bottomSection: some View {
    VStack(alignment: .center) {
      if locationManager.location != nil {
        ForEach(0..<min(homeTabViewModel.forecastDaysOfWeek.count, 5), id: \.self) { index in

          WeatherForecastCardView(
            temperatureValue: homeTabViewModel.forecastTemperatures[index],
            weekDay: homeTabViewModel.forecastDaysOfWeek[index],
            weatherIconName: homeTabViewModel.forecastIconNames[index]
          )
          .padding(.bottom)
        }
      } else {
        Text("Please Ensure Your Location Can Be Accessed")
      }
    }
    .padding(.top, 10)
    .padding(5)
  }
}
