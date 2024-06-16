//
//  FavouritesDetailedViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import UIKit

class FavouritesDetailedViewController: UIViewController {
  @IBOutlet var heading: UILabel!
  @IBOutlet var currentTemperatureLabel: UILabel!
  @IBOutlet var currentWeatherDescriptionLabel: UILabel!
  @IBOutlet var currentTempLabel: UILabel!
  @IBOutlet var changeText: UILabel!
  @IBOutlet var maxTempLabel: UILabel!
  @IBOutlet var minTempLabel: UILabel!
  @IBOutlet var backgroundImage: UIImageView!

  var background: UIColor?
  var changeTextValue: String?
  var currentTempValue: String?
  var minValue: String?
  var maxValue: String?
  var cityName: String?
  override func viewDidLoad() {
    super.viewDidLoad()
    //  view.backgroundColor = .white
    heading.text = "This heading"
    changeText.text = changeTextValue ?? "Change This"
    loadData()
  }

  func loadData() {
    title = cityName ?? "Weather"
    currentTemperatureLabel.text = currentTempValue ?? "10"
    maxTempLabel.text = maxValue ?? "18"
    minTempLabel.text = minValue ?? "13"
  }
}
