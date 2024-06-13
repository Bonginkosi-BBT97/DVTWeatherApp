//
//  WeatherForecastCardView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import SwiftUI

struct WeatherForecastCardView: View {
  let temperatureValue: String
  let weekDay: String
  let weatherIconName: String

  var body: some View {
    HStack(alignment: .center) {
      Text(weekDay)
        .font(.subheadline)
        .bold()
      Spacer()
      Image(weatherIconName)
        .scaledToFill()
      Spacer()
      ZStack(alignment: .topTrailing) {
        Text(temperatureValue)
        Text("°")
          .offset(x: 10, y: -10)
      }
    }
    .padding([.trailing, .leading], 30)
    .foregroundColor(.white)
  }
}

#Preview {
  WeatherForecastCardView(temperatureValue: "25", weekDay: "Tuesday", weatherIconName: "sun.max")
}
