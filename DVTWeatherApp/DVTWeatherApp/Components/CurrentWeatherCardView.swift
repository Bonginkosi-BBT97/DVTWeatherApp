//
//  CurrentWeatherCardView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import SwiftUI

struct CurrentWeatherCardView: View {
  let weatherValue: String
  let title: String

  var body: some View {
    VStack(alignment: .center, spacing: -10) {
      ZStack(alignment: .topTrailing) {
        Text(weatherValue)
          .font(.subheadline)
          .fontWeight(.bold)
        Text("°")
          .font(.title)
          .offset(x: 10, y: -10)
      }
      Text(title)
        .font(.caption)
    }
    .padding()
    .foregroundColor(.gray)
  }
}

#Preview {
  CurrentWeatherCardView(weatherValue: "19", title: "min")
}
