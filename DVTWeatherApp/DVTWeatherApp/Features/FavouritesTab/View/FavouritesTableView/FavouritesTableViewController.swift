//
//  FavouritesTableViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
  var items = ["Johannesburg 12° CLEAR", "Durban 15° CLOUDY", "Pretoria 20° SUNNY "]

  override func viewDidLoad() {
    super.viewDidLoad()

    let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "Cell")
    tableView.backgroundColor = .white

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addButtonTapped)
    )
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FavouriteTableViewCell
    else {
      return UITableViewCell()
    }

    let item = items[indexPath.row].components(separatedBy: " ")
    let cityName = item[0]
    let temperature = item[1]
    let weatherDescription = item[2]

    cell.cityName.text = cityName
    cell.weatherTemperature.text = temperature
    cell.weatherDescription.text = weatherDescription
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
