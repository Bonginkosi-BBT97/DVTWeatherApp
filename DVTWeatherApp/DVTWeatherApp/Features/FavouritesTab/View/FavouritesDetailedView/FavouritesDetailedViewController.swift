//
//  FavouritesDetailedViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import UIKit

class FavouritesDetailedViewController: UIViewController {
  @IBOutlet var currentTemperatureLabel: UILabel!
  @IBOutlet var currentWeatherDescriptionLabel: UILabel!
  @IBOutlet var currentTempLabel: UILabel!
  @IBOutlet var maxTempLabel: UILabel!
  @IBOutlet var minTempLabel: UILabel!
  @IBOutlet var backgroundImage: UIImageView!

  var backgroundColour: UIColor?
  var currentTempValue: String?
  var minValue: String?
  var maxValue: String?
  var cityName: String?
  var weatherDescription: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }

  private func loadData() {
    title = cityName ?? "Weather"
    currentTemperatureLabel.text = currentTempValue ?? "N/A"
    maxTempLabel.text = maxValue ?? "N/A"
    minTempLabel.text = minValue ?? "N/A"
    currentTempLabel.text = currentTempValue ?? "N/A"
    currentWeatherDescriptionLabel.text = weatherDescription ?? "N/A"
  }
}
