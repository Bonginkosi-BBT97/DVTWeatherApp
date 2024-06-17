//
//  FavouritesTableViewController+Extension.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import UIKit

extension FavouritesTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favouritesViewModel.cities.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FavouriteTableViewCell
    else {
      return UITableViewCell()
    }

    let city = favouritesViewModel.cities[indexPath.row]
    if let cityName = city.name, let weather = favouritesViewModel.weatherData[cityName] {
      cell.cityName.text = weather.name
      cell.weatherTemperature.text = "\(WeatherUtilities.roundTemperatureString(from: weather.main.temp))°"
      cell.weatherDescription.text = weather.weather.first?.description
    }

    cell.backgroundColor = .white
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let city = favouritesViewModel.cities[indexPath.row]
    let storyboard = UIStoryboard(name: "FavouritesDetailView", bundle: nil)
    if let detailViewController = storyboard
      .instantiateViewController(
        withIdentifier: "FavouritesDetailViewController"
      ) as? FavouritesDetailViewController
    {
      if let cityName = city.name, let weather = favouritesViewModel.weatherData[cityName] {
        detailViewController.cityName = weather.name
        detailViewController
          .currentTempValue = "\(WeatherUtilities.roundTemperatureString(from: weather.main.temp))°"
        detailViewController
          .minValue = "\(WeatherUtilities.roundTemperatureString(from: weather.main.tempMin))°"
        detailViewController
          .maxValue = "\(WeatherUtilities.roundTemperatureString(from: weather.main.tempMax))°"
        detailViewController.weatherDescription = weather.weather.first?.main
        detailViewController
          .backgroundImageName =
          "\(BackgroundImageName(description: WeatherDescription(description: weather.weather.first?.main ?? "SUNNY")))"
      }

      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }

  @objc func addButtonTapped() {
    let searchViewController = FavouritesSearchViewController()
    searchViewController.delegate = self
    searchViewController.modalPresentationStyle = .popover
    searchViewController.modalTransitionStyle = .coverVertical
    present(searchViewController, animated: true, completion: nil)
    tableView.reloadData()
  }

  @objc func deleteButtonTapped() {
    let alertController = UIAlertController(
      title: "Confirm Deletion",
      message: "Are you sure you want to delete all favourite cities?",
      preferredStyle: .alert
    )

    let clickedYes = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
      self?.favouritesViewModel.clearAllCities()
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }

    let clickedNo = UIAlertAction(title: "No", style: .cancel, handler: nil)

    alertController.addAction(clickedYes)
    alertController.addAction(clickedNo)

    present(alertController, animated: true, completion: nil)
  }

  func didSaveCity() {
    favouritesViewModel.fetchCities()

    if let latestCity = favouritesViewModel.cities.last?.name {
      Task {
        await favouritesViewModel.fetchWeatherData(for: latestCity)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
}
