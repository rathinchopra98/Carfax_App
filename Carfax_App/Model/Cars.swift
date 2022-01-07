//
//  Cars.swift
//  Carfax_App
//
//  Created by Rathin Chopra on 2022-01-06.
//

import Foundation

class Car {
    var carMake: String
    var carModel: String
    var carLocation: String
    var carImage: String
    var carMakeYear: String
    var carTrim: String
    var carPrice: Double
    var carMileage: Double
    var carDealerPhone: String
    
    init(carMake: String, carModel: String, carLocation: String, carImage: String, carMakeYear: String, carTrim: String, carPrice: Double, carMileage: Double, carDealerPhone: String) {
        self.carMake = carMake
        self.carModel = carModel
        self.carLocation = carLocation
        self.carImage = carImage
        self.carMakeYear = carMakeYear
        self.carTrim = carTrim
        self.carPrice = carPrice
        self.carMileage = carMileage
        self.carDealerPhone = carDealerPhone
    }
}
