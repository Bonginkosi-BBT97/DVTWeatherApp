//
//  MockURLSession.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import Foundation

class MockURLSession: URLSessionProtocol {
  var data: Data?
  var response: URLResponse?
  var error: Error?

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    if let error = error {
      throw error
    }
    return (data ?? Data(), response ?? URLResponse())
  }
}

extension URLSession: URLSessionProtocol {}

protocol URLSessionProtocol {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
