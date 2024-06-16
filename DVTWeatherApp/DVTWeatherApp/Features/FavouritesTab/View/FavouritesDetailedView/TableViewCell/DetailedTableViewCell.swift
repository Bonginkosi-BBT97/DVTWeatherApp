//
//  DetailedTableViewCell.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/16.
//

import UIKit

class DetailedTableViewCell: UITableViewCell {
  @IBOutlet var dayOfWeekLabel: UILabel!

  @IBOutlet var weatherIcon: UIImageView!
  @IBOutlet var forecastTempLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
