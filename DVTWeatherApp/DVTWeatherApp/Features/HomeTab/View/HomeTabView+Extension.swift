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
      Image(backgroundImageName)
        .resizable()
        .scaledToFit()
        .ignoresSafeArea(.all)

      VStack {
        ZStack(alignment: .topTrailing) {
          Text(currentTemperature)
            .font(.largeTitle)
            .bold()
          Text("°")
            .font(.largeTitle)
            .offset(x: 12, y: -5)
        }
        Text(weatherTitle)
          .font(.largeTitle)
      }
      .foregroundColor(.white)
      .padding(.bottom, 150)
    }
  }

  var middleSection: some View {
    VStack {
      HStack {
        CurrentWeatherCardView(temperatureValue: "19", title: "min")
        Spacer()
        CurrentWeatherCardView(temperatureValue: currentTemperature, title: "Current")
        Spacer()
        CurrentWeatherCardView(temperatureValue: "27", title: "max")
      }
    }
    .padding(.top, -80)
  }

  var bottomSection: some View {
    VStack {
      WeatherForecastCardView(temperatureValue: "20", weekDay: "Tuesday", weatherIconName: "sun.max")
    }
    .padding(.top, 10)
    .padding(5)
  }
}
