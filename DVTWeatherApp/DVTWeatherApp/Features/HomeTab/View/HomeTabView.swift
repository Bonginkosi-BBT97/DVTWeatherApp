//
//  HomeTabView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import SwiftUI

struct HomeTabView: View {
  let currentTemperature: String
  let weatherTitle: String

  var body: some View {
    ZStack {
      VStack {
        ZStack(alignment: .topTrailing) {
          Text(currentTemperature)
                .font(.largeTitle)
            .fontWeight(.bold)
          Text("°")
            .font(.largeTitle)
            .offset(x: 10, y: -10)
        }
          Text(weatherTitle)
              .font(.largeTitle)
          
          HStack {
              CurrentWeatherCardView(temperatureValue: "19", title: "min")
              Spacer()
              CurrentWeatherCardView(temperatureValue: "25", title: "Current")
              Spacer()
              CurrentWeatherCardView(temperatureValue: "27", title: "max")
          }
          Divider()
              .background(Color.white)
      }
    }
  }
}

#Preview {
  HomeTabView(currentTemperature: "25", weatherTitle: "SUNNY")
}
