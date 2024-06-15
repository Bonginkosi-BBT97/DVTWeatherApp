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
      cell.weatherTemperature.text = "\(weather.main.temp)"
      cell.weatherDescription.text = weather.weather.first?.description ?? ""
    }

    cell.backgroundColor = .white
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let detailViewController = FavouritesDetailedViewController()
    navigationController?.pushViewController(detailViewController, animated: true)
  }

  @objc func addButtonTapped() {
    let searchViewController = FavouritesSearchViewController()
    searchViewController.modalPresentationStyle = .popover
    searchViewController.modalTransitionStyle = .coverVertical
    present(searchViewController, animated: true, completion: nil)
  }
}
