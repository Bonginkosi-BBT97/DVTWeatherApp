//
//  FavouriteTableViewCell.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
  @IBOutlet var cityName: UILabel!
  @IBOutlet var weatherDescription: UILabel!
  @IBOutlet var weatherTemperature: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    cityName.textColor = .black
    weatherDescription.textColor = .black
    weatherTemperature.textColor = .black
  }
}
