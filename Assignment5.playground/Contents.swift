//: Playground - noun: a place where people can play

import UIKit

let daysInMonth:[Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func isLeap(year:Int) -> Bool {
    return (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
}

func julianDate(year: Int, month: Int, day: Int) -> Int {
    let yearDuration: Int = Array(1900..<year).reduce(0, combine:{$0 + (isLeap($1) == true ? 366 : 365)})
    let monthDuration: Int = Array(1..<month).reduce(0, combine:{$0 + daysInMonth[$1]})
    return yearDuration + monthDuration + day + (isLeap(year) == true && month > 2 ? 1 : 0)
}

julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

isLeap(1960)
isLeap(1900)
isLeap(2000)




//Class Project Bonus Proposal:

//My proposal in this project is to add changes to the model to explore different rule options, specifically mutation. This would be one of two new Grids that I would provide for the Final Project. It would support random mutation for different cells once every 5 steps.

//The second Grid would be a change to the UI to create an interesting theme and entertaining user experience. The theme would be a Pac-Man theme that would not only change the color design of the Grid but would include a small Pac-Man moving through the Grid every step and any cell it crossed would go through a function that could turn a current cell state into a random cell state.