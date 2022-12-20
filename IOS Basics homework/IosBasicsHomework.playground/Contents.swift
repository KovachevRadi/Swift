import UIKit

enum Currency: String {
    case BGN
    case EUR
    case USD
    
    var rateToBGN: Double {
        switch self {
        case .BGN:
            return 1
        case .EUR:
            return 1.956
        case .USD:
            return 1.858
        }
    }
    
    func convertToBGN(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .BGN:
            return amount
        case .EUR, .USD:
            return amount*(self.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
    
    func convertToEUR(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .EUR:
            return amount
        case .BGN:
            return amount/(Currency.EUR.rateToBGN/(1+currencyFeeInPercent/100))
        case .USD:
            return amount/(Currency.USD.rateToBGN/Currency.EUR.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
    
    func convertToUSD(amount: Double, currencyFeeInPercent: Double) -> Double {
        switch self {
        case .USD:
            return amount
        case .BGN:
            return amount/(Currency.USD.rateToBGN/(1+currencyFeeInPercent/100))
        case .EUR:
            return amount/(Currency.EUR.rateToBGN/Currency.USD.rateToBGN/(1+currencyFeeInPercent/100))
        }
    }
}
    struct BankAccount {
        var owner: User
        var iban: String
        var balances: [Currency:Double]
    }
    
    struct User {
        var id: String
        var name: String
    }
    
    class ATM {
        var id: String = ""
        var changeFee: Double = 2.0
        var balances: [Currency:Double]
        
        init(id: String, changeFee: Double, balances: [Currency:Double]) {
            self.id = id
            self.changeFee = changeFee
            self.balances = balances
        }
        
        func getBalanceBy(currency: Currency) -> Double {
            return self.balances[currency] ?? 0.0
        }
        
        func withDrawMoney (card: Card, currency: Currency, amount: Double, pinCode: String) {
            
            if  self.getBalanceBy(currency: currency) < amount {
                print("Not enough balance \(currency) in the ATM")
                return
            }
            
            switch currency {
                
            case .BGN:
                if amount > card.totalBalanceIn(currency: currency) {
                    print("Not enough money in the card")
                }
            case .EUR:
                if amount > card.getBalanceBy(currency: currency) {
                    print("Not enough money in the card")
                }
            case .USD:
                if amount > card.getBalanceBy(currency: currency) {
                    print("Not enough money in the card")
                }
            }
            
            if pinCode != card.pinCode {
                print("Wrong PIN")
            }
            
            switch currency {
                
            case .BGN:
                getCurrencyToWithdraw
            case .EUR, .USD:
                if var cardBalances = card.bankAccount?.balances {
                    cardBalances[currency] = cardBalances[currency] ?? 0.0 - amount
                    card.bankAccount?.balances = cardBalances
                    self.balances[currency] = (self.balances[currency] ?? 0.0) - amount
                }
            }
        }
    }
    
    class Card {
        var id: String = ""
        var pinCode: String = ""
        var user: User?
        var bankAccount: BankAccount?
        
        init(id: String, pinCode: String, user: User, bankAccount: BankAccount) {
            self.id = id
            self.pinCode = pinCode
            self.user = user
            self.bankAccount = bankAccount
        }
        
        func getBalanceBy(currency: Currency) -> Double {
            return self.bankAccount?.balances[currency] as? Double ?? 0.0
        }
        
        func totalBalanceIn(currency:Currency) -> Double {
            var totalBalance = 0.0
            if let bankAccountBalances = self.bankAccount?.balances {
                for currencyBalance in bankAccountBalances {
                    let currencyBalanceValue = currencyBalance.value
                    switch currencyBalance.key {
                    case .BGN:
                        switch currency {
                        case .BGN:
                            totalBalance += currencyBalanceValue
                        case .EUR:
                            totalBalance += currencyBalanceValue / 1.956
                        case .USD:
                            totalBalance += currencyBalanceValue / 1.858
                        }
                    case .EUR:
                        switch currency {
                        case .BGN:
                            totalBalance += currencyBalanceValue * 1.956
                        case .EUR:
                            totalBalance += currencyBalanceValue
                        case .USD:
                            totalBalance += currencyBalanceValue * 1.0527
                        }
                    case .USD:
                        switch currency {
                        case .BGN:
                            totalBalance += currencyBalanceValue * 1.858
                        case .EUR:
                            totalBalance += currencyBalanceValue * 0.94989
                        case .USD:
                            totalBalance += currencyBalanceValue
                        }
                    }
                }
            }
            
            return totalBalance
        }
    }
    
    func getCurrencyToWithdraw(amount: Double, fee: Double, card: Card) -> (currency: Currency?, amount: Double) {
        guard let bankAccount = card.bankAccount else {
            return (nil, 0.0)
        }
        
        if amount <= bankAccount.balances[.BGN]! {
            return (.BGN, amount)
        } else if Currency.BGN.convertToEUR(amount: amount, currencyFeeInPercent: fee) <= bankAccount.balances[.EUR]! {
            return (.EUR, Currency.BGN.convertToEUR(amount: amount, currencyFeeInPercent: fee))
        } else if Currency.BGN.convertToUSD(amount: amount, currencyFeeInPercent: fee) <= bankAccount.balances[.USD]! {
            return (.USD, Currency.BGN.convertToUSD(amount: amount, currencyFeeInPercent: fee))
        } else {
            return (nil, 0)
        }
    }
    
    var atm = ATM(
        id: "1234",
        changeFee: 2.3,
        balances: [
            Currency.BGN : 1000.0,
            Currency.EUR : 1000.0,
            Currency.USD : 1000.0
        ])
    
    var radko = User(id: "4532", name: "Radko")
    var goshko = User(id: "6863", name: "Goshko")
    var bankAccount = BankAccount(owner: radko, iban: "GB82 WEST 1234 5698 7654 32", balances: [
        Currency.BGN : 100.0,
        Currency.EUR : 100.0,
        Currency.USD : 100.0
    ])
    
var cardForRadko = Card(id: "8356", pinCode: "1213", user: radko, bankAccount: bankAccount)
    var cardForGoshko = Card(id: "9812", pinCode: "7777", user: goshko, bankAccount: bankAccount)
    atm.withDrawMoney(card: cardForRadko, currency: .EUR, amount: 50, pinCode: "1213")
    print(atm.balances[.EUR])

print()

