import UIKit

func calculationTriagleSurface(side: Float, hight: Float) -> String {
    let result: Float = (side * hight) / 2
    return "Surface triangle = \(result)"
}

print(calculationTriagleSurface(side: 5.0, hight: 4.0))


func calculationCyrcleSurfaceAndPerimeter(radius: Float) -> String {
    let resultSurface: Float = Float.pi * pow(radius, 2)
    let resultPerimeter: Float = 2 * Float.pi * radius
    return "Surface cyrcle = \(resultSurface) \nPerimeter cyrcle = \(resultPerimeter) "
}

print(calculationCyrcleSurfaceAndPerimeter(radius: 8.0))

struct Car {
    var make: String
    var model: String
    var horsePower: Double
    var torque: Float
    var dateOfManufacturing: String
}
let car = Car(make: "Lada", model: "Niva", horsePower: 75.0, torque: 120.0, dateOfManufacturing: "31/05/1980")


func printInformation(car:Car) -> String {
    return "make - \(car.make), model - \(car.model), horsePower - \(car.horsePower), torque - \(car.torque), dateOfManufacturing - \(car.dateOfManufacturing)"
}

func convertHorsePowerToWatts(car: Car) -> Double {
    let horsePowerToWatts = car.horsePower * 746
    return horsePowerToWatts
}

print(printInformation(car: car))
print("Power in watts - \(convertHorsePowerToWatts(car: car)) W")

