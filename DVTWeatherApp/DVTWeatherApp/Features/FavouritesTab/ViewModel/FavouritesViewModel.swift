//
//  FavouritesViewModel.swift
//  
//
//  Created by Bonginkosi Tshabalala on 2024/06/15.
//

import Foundation
import CoreData

class FavouritesViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
    }
}
