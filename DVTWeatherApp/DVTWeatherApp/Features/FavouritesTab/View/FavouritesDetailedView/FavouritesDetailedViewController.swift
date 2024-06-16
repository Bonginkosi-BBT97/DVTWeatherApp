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

  @IBOutlet var changeText: UILabel!

  var changeTextValue: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    //  view.backgroundColor = .white
    title = "Detail"
    heading.text = "This heading"
    changeText.text = changeTextValue ?? "Change This"
  }
}
