import UIKit



enum Currency: String {
    case BGN
    case USD
    case EUR
}

struct Card {
    var pinCode: String
    var owner: String
    var cardAccounts: [String: Double]
    
    func printCardBalance() {
        print("Card balance \(cardAccounts)")
    }
}

struct ATM {
    var id: String
    var availabilityАТМ: [String: Double]
    var currencyFee: Double
    
    mutating func withdrawing (card: Card, amount: Double, pin: String) -> [String: Double]{
        
        if pin != card.pinCode {
            print("Wrong PIN code!")
            return card.cardAccounts
        }
         
        if self.availabilityАТМ[Currency.BGN.rawValue] ?? 0.0 < amount {
            print("Not enough money in the ATM")
            
        }
        
        
        var totalBalanceCard = 0.0
        card.cardAccounts.forEach({totalBalanceCard += $0.value})

        if totalBalanceCard < amount {
            print("Недостатъчна наличност по вашата сметка")
            return card.cardAccounts
        }
        var currentAmount = amount
        var currentCardAccounts = card.cardAccounts
        availabilityАТМ[Currency.BGN.rawValue] = self.availabilityАТМ[Currency.BGN.rawValue] ?? 0.0  - currentAmount
        for currencyName in card.cardAccounts.keys {
            switch Currency(rawValue: currencyName) {
            case .BGN:
                if currentCardAccounts[Currency.BGN.rawValue] ?? 0.0 >= currentAmount {
                    currentCardAccounts[Currency.BGN.rawValue] = (currentCardAccounts[Currency.BGN.rawValue] ?? 0.0) - currentAmount
                    return currentCardAccounts
                } else {
                    currentCardAccounts[Currency.BGN.rawValue] = (currentCardAccounts[Currency.BGN.rawValue] ?? 0.0) - (currentCardAccounts[Currency.BGN.rawValue] ?? 0.0)
                    currentAmount = currentAmount - (currentCardAccounts[Currency.BGN.rawValue] ?? 0.0)
                }
            case .EUR:
                if ((currentCardAccounts[Currency.EUR.rawValue] ?? 0.0) * 1.956) >= currentAmount {
                    currentCardAccounts[Currency.EUR.rawValue] = (currentCardAccounts[Currency.EUR.rawValue] ?? 0.0) - (currentAmount / 1.956)
                    return currentCardAccounts
                } else {
                    currentCardAccounts[Currency.EUR.rawValue] = (currentCardAccounts[Currency.EUR.rawValue] ?? 0.0) - (currentCardAccounts[Currency.EUR.rawValue] ?? 0.0)
                    currentAmount = currentAmount - ((currentCardAccounts[Currency.EUR.rawValue] ?? 0.0) * 1.956)
                }
            case .USD:
                if ((currentCardAccounts[Currency.USD.rawValue] ?? 0.0) * 1.858) >= currentAmount {
                    currentCardAccounts[Currency.USD.rawValue] = (currentCardAccounts[Currency.USD.rawValue] ?? 0.0) - (currentAmount / 1.858)
                    return currentCardAccounts
                } else {
                    currentCardAccounts[Currency.USD.rawValue] = (currentCardAccounts[Currency.USD.rawValue] ?? 0.0) - (currentCardAccounts[Currency.USD.rawValue] ?? 0.0)
                    currentAmount = currentAmount - ((currentCardAccounts[Currency.USD.rawValue] ?? 0.0) * 1.858)
                }
            default:
                break
            }
        }
        
        return card.cardAccounts
    }
    
    func printATMBalance() {
        print(self.availabilityАТМ[Currency.BGN.rawValue])
    }
}

// Example 1
print("Example 1")
var atm = ATM(id: "1312", availabilityАТМ: [Currency.USD.rawValue: 0, Currency.BGN.rawValue: 20.0, Currency.EUR.rawValue: 0.0], currencyFee: 0.0)
var card = Card(pinCode: "1919", owner: "Radi Kovachev", cardAccounts: [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 0.0, Currency.BGN.rawValue: 80.0])

card.cardAccounts = atm.withdrawing(card: card, amount: 20.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

// Example 2
print("Example 2")
atm.availabilityАТМ[Currency.BGN.rawValue] = 100.0
card.cardAccounts = [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 0.0, Currency.BGN.rawValue: 80.0]

card.cardAccounts = atm.withdrawing(card: card, amount: 80.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

// Example 3
print("Example 3")
atm.availabilityАТМ[Currency.BGN.rawValue] = 100.0
card.cardAccounts = [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 0.0, Currency.BGN.rawValue: 80.0]

card.cardAccounts = atm.withdrawing(card: card, amount: 90.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

// Example 4
print("Example 4")
atm.availabilityАТМ[Currency.BGN.rawValue] = 60.0
card.cardAccounts = [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 0.0, Currency.BGN.rawValue: 80.0]

card.cardAccounts = atm.withdrawing(card: card, amount: 80.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

// Example 5
print("Example 5")
atm.availabilityАТМ[Currency.BGN.rawValue] = 100.0
card.cardAccounts = [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 60.0, Currency.BGN.rawValue: 80.0]

card.cardAccounts = atm.withdrawing(card: card, amount: 100.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

// Example 6
print("Example 6")
atm.availabilityАТМ[Currency.BGN.rawValue] = 400.0
card.cardAccounts = [Currency.USD.rawValue: 0.0, Currency.EUR.rawValue: 60.0, Currency.BGN.rawValue: 80.0]

card.cardAccounts = atm.withdrawing(card: card, amount: 150.0, pin: "1919")
print(atm.printATMBalance())
print(card.printCardBalance())

