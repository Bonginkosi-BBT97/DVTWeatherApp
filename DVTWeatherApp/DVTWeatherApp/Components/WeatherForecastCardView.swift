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
        .frame(width: 70, alignment: .leading)
      Spacer()
      Image(weatherIconName)
        .resizable()
        .scaledToFit()
        .frame(width: 25, height: 25)
      Spacer()
      ZStack(alignment: .topTrailing) {
        Text(temperatureValue)
        Text("°")
          .offset(x: 10, y: -10)
      }
      .padding(.trailing, 15)
    }
    .padding([.trailing, .leading], 50)
    .foregroundColor(.white)
  }
}

#Preview {
  WeatherForecastCardView(temperatureValue: "25", weekDay: "Tuesday", weatherIconName: "sun.max")
}
