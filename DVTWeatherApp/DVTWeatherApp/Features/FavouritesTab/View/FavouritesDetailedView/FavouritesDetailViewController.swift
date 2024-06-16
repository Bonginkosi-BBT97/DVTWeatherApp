//
//  FavouritesDetailViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import UIKit

class FavouritesDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet var currentTemperatureLabel: UILabel!
  @IBOutlet var currentWeatherDescriptionLabel: UILabel!
  @IBOutlet var currentTempLabel: UILabel!
  @IBOutlet var maxTempLabel: UILabel!
  @IBOutlet var minTempLabel: UILabel!
  @IBOutlet var backgroundImage: UIImageView!

  @IBOutlet var currentTemperaturesStack: UIStackView!
  @IBOutlet var weatherForecastTableView: UITableView!

  var backgroundColour: UIColor?
  var currentTempValue: String?
  var minValue: String?
  var maxValue: String?
  var cityName: String?
  var weatherDescription: String?
  var backgroundImageName: String?
  override func viewDidLoad() {
    super.viewDidLoad()
    loadTopSectionData()
    setupTableView()
  }

  private func loadTopSectionData() {
    title = cityName ?? "Weather"
    currentTemperatureLabel.text = currentTempValue ?? "N/A"
    maxTempLabel.text = maxValue ?? "N/A"
    minTempLabel.text = minValue ?? "N/A"
    currentTempLabel.text = currentTempValue ?? "N/A"
    currentWeatherDescriptionLabel.text = weatherDescription ?? "N/A"
    let imageName = backgroundImageName ?? "sunny"
    backgroundImage.image = UIImage(named: imageName)
    backgroundColour =
      UIColor(
        BackgroundColorCode(imageName: BackgroundImageName(rawValue: backgroundImageName ?? "sunny") ?? .sunny)
          .color
      )
    currentTemperaturesStack.backgroundColor = backgroundColour
    view.backgroundColor = backgroundColour

    weatherForecastTableView.reloadData()
  }

  private func setupTableView() {
    weatherForecastTableView.dataSource = self
    weatherForecastTableView.delegate = self
    weatherForecastTableView.register(
      UINib(nibName: "DetailTableViewCell", bundle: nil),
      forCellReuseIdentifier: "DetailViewCell"
    )
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as? DetailTableViewCell

    else {
      return UITableViewCell()
    }
    cell.backgroundColour = backgroundColour
    return cell
  }
}
