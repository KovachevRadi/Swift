import UIKit

// Task 1.1

func averageFuel(liters: Double, distance: Double) -> Double {
    var averegeFuelPer100Km = (liters * 100) / distance
    return averegeFuelPer100Km
}
print("Consuption by 100km is:\(averageFuel(liters: 50.0, distance: 200.0))")

// Task 1.2

struct DataOfFueling {
    var date: String
    var distance: Double
    var amountOfFuel: Double
}

var fuelingData = [DataOfFueling]()


func fuelConsumptionBetweenCurrentAndLastFueling(date: String, distance: Double, amountOfFuel: Double) {
   
    let currentData = DataOfFueling(date: date, distance: distance, amountOfFuel: amountOfFuel)
    
    let previusData = fuelingData.last ?? currentData
    
    fuelingData.append(currentData)
    
    let avarege = (averageFuel(liters: currentData.amountOfFuel, distance: currentData.distance) + averageFuel(liters: previusData.amountOfFuel, distance: previusData.distance)) / 2.0
    
    print("Average between the first and the last date = \(avarege)L/100km")
}

fuelConsumptionBetweenCurrentAndLastFueling(date: "12/12/2022", distance: 120.0, amountOfFuel: 9.0)
fuelConsumptionBetweenCurrentAndLastFueling(date: "12/12/2022", distance: 140.0, amountOfFuel: 10.0)
fuelConsumptionBetweenCurrentAndLastFueling(date: "14/12/2022", distance: 160.0, amountOfFuel: 11.0)


// Task 1.3

func convertinLiterPer100KmToMpg (liters: Double) -> Double {
    
    let mpg = 282.48 / liters
    return mpg
}

print("\(convertinLiterPer100KmToMpg(liters: 10.0)) mpg")

// Task 1.4
func calculationAveragePricePerKilometer (pricePerLiterPrice: Double) {
    
    var average = 0.0
    
    for data in fuelingData {
        average += averageFuel(liters: data.amountOfFuel, distance: data.distance)
    }
    
    let averageNumber = average / Double(fuelingData.count)
    let literPricePerKilometer = (pricePerLiterPrice * averageNumber) / 100
    
    print(String(format: "Average price per kilometer = %.2f lv.", literPricePerKilometer))
}

calculationAveragePricePerKilometer(pricePerLiterPrice: 5.50)

// Task 1.5

func informationAboutConsumtionAndDate (date: String, price: Double) {
    
        var result = [DataOfFueling]()

    for data in fuelingData {
        if data.date == date {
            result.append(data)
        }
    }

    if result.isEmpty {
        print("no data")
    } else {
        var consumtionLiters = 0.0
        for item in result {
            consumtionLiters += item.amountOfFuel
        }
       print(String(format: "Consumation for \(date) = %.2f ", consumtionLiters * price))
    }
}

informationAboutConsumtionAndDate(date: "12/12/2022", price: 5.50)
