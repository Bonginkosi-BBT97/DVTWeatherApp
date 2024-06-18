//
//  FavouritesDetailViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Combine
import Foundation
import SwiftUI
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

  private var favouritesViewModel = FavouritesViewModel()
  private var cancellables = Set<AnyCancellable>()

  var backgroundColour: UIColor?
  var currentTempValue: String?
  var minValue: String?
  var maxValue: String?
  var cityName: String?
  var weatherDescription: String?
  var backgroundImageName: String?
  let dataNotAvailable = "N/A"

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.tintColor = .white

    if let cityName = cityName {
      favouritesViewModel.fetchWeatherForecast(for: cityName)
    }
    loadTopSectionData()
    setupTableView()
    setupBindings()
  }

  private func setupBindings() {
    favouritesViewModel.$forecastDaysOfWeek
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.weatherForecastTableView.reloadData()
      }
      .store(in: &cancellables)
  }

  private func loadTopSectionData() {
    title = cityName ?? "Weather"
    favouritesViewModel.fetchWeatherForecast(for: "Cape Town")
    currentTemperatureLabel.text = currentTempValue ?? dataNotAvailable
    maxTempLabel.text = maxValue ?? dataNotAvailable
    minTempLabel.text = minValue ?? dataNotAvailable
    currentTempLabel.text = currentTempValue ?? dataNotAvailable
    currentWeatherDescriptionLabel.text = weatherDescription ?? dataNotAvailable
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
    return favouritesViewModel.forecastDaysOfWeek.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as? DetailTableViewCell

    else {
      return UITableViewCell()
    }
    cell.dayOfWeekLabel.text = favouritesViewModel.forecastDaysOfWeek[indexPath.row]
    cell.forecastTempLabel.text = "\(favouritesViewModel.forecastTemperatures[indexPath.row])°"
    cell.weatherIcon.image = UIImage(named: favouritesViewModel.forecastIconNames[indexPath.row])
    cell.stackViewContainer.backgroundColor = backgroundColour

    return cell
  }
}
