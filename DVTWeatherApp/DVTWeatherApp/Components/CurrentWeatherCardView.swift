//
//  CurrentWeatherCardView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import SwiftUI

struct CurrentWeatherCardView: View {
  let temperatureValue: String
  let title: String

  var body: some View {
    VStack(alignment: .center, spacing: -10) {
      ZStack(alignment: .topTrailing) {
        Text(temperatureValue)
          .font(.subheadline)
          .fontWeight(.bold)
        Text("°")
          .font(.title)
          .offset(x: 10, y: -12)
      }
      Text(title)
        .font(.subheadline)
    }
    .padding()
    .foregroundColor(.white)
  }
}

#Preview {
  CurrentWeatherCardView(temperatureValue: "19", title: "min")
}
