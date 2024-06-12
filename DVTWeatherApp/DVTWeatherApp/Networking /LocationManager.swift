//
//  LocationManager.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Foundation
import MapKit

@MainActor
class LocationManager: NSObject, ObservableObject {
  @Published var location: CLLocation?
  @Published var region = MKCoordinateRegion()

  private let locationManager = CLLocationManager()

  override init() {
    super.init()
    locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    locationManager.distanceFilter = kCLDistanceFilterNone

    locationManager.delegate = self

    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    self.location = location
    region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
  }
}
