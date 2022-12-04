import UIKit

func averageFuelConsumptionInLitersPer100Km(litters: Double) -> Double {
    let averageConsumption = (litters * 100) / 100
    return averageConsumption
}

print(averageFuelConsumptionInLitersPer100Km(litters: 40))
