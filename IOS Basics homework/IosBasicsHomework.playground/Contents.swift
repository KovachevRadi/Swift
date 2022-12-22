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
        var fee:Double = 0.02
        
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
                var currentAmount = amount
                guard var currentBalances = card.bankAccount?.balances else {
                    return
                }
                let currencyKeys = currentBalances.keys.sorted(by: {$0.rawValue < $1.rawValue}).map({$0.rawValue})
                for item in currencyKeys {
                    if let currencyKey = Currency(rawValue: item) {
                        currentAmount = currentAmount / currencyKey.rateToBGN
                        currentAmount = currencyKey != .BGN ? (currentAmount * (1 + self.fee)) : currentAmount
                        if currentBalances[currencyKey] ?? 0.0 >= currentAmount {
                            currentBalances[currencyKey] = (currentBalances[currencyKey] ?? 0.0) - currentAmount
                            card.bankAccount?.balances = currentBalances
                            self.balances[currencyKey] = (self.balances[currencyKey] ?? 0.0) - currentAmount
                            return
                        } else {
                            currentBalances[currencyKey] = (currentBalances[currencyKey] ?? 0.0) - (currentBalances[currency] ?? 0.0)
                            card.bankAccount?.balances = currentBalances
                            self.balances[currencyKey] = (self.balances[currencyKey] ?? 0.0) - (currentBalances[currencyKey] ?? 0.0)
                            currentAmount = currentAmount - (currentBalances[currencyKey] ?? 0.0)
                        }
                    }
                }
                
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
    

    var atm = ATM(
        id: "1234",
        changeFee: 2.3,
        balances: [
            Currency.BGN : 800.0,
            Currency.EUR : 600.0,
            Currency.USD : 700.0
        ])
    
    var radko = User(id: "4532", name: "Radko")
    var goshko = User(id: "6863", name: "Goshko")
    var bankAccount = BankAccount(owner: radko, iban: "GB82 WEST 1234 5698 7654 32", balances: [
        Currency.BGN : 30,
        Currency.EUR : 70,
        Currency.USD : 50
    ])
    
    var cardForRadko = Card(id: "8356", pinCode: "1213", user: radko, bankAccount: bankAccount)
    var cardForGoshko = Card(id: "9812", pinCode: "7777", user: goshko, bankAccount: bankAccount)
    

//Example 1
print("Баланси преди теглене")
print(cardForRadko.bankAccount?.balances ?? "")
print(atm.balances)
atm.withDrawMoney(card: cardForRadko, currency: .BGN, amount: 50, pinCode: "1213")
print("Баланси след теглене")
print(cardForRadko.bankAccount?.balances ?? "")
print(atm.balances)

