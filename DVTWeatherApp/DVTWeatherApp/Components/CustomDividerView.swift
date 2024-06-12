//
//  CustomDividerView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Foundation
import SwiftUI

struct CustomDividerView: View {
  var color: Color = .white
  var height: CGFloat = 1

  var body: some View {
    Rectangle()
      .fill(color)
      .frame(height: height)
      .edgesIgnoringSafeArea(.horizontal)
  }
}

struct DividerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomDividerView()
  }
}
