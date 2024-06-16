//
//  DetailTableViewCell.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/16.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
  @IBOutlet var dayOfWeekLabel: UILabel!

  @IBOutlet var mainView: UIView!
  @IBOutlet var weatherIcon: UIImageView!
  @IBOutlet var forecastTempLabel: UILabel!
  var backgroundColour: UIColor?

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
