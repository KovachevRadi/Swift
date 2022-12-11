import UIKit

let score1 = 123
let score2 = 124

enum Winner: String{
    case team1
    case team2
    case tie
}

var winner: Winner = score1 == score2 ? .tie : score1 > score2 ? .team1 : .team2

switch score1 == score2{
case true:
        winner = .tie
default:
    winner
}


print(winner.rawValue)
