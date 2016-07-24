//: Playground - noun: a place where people can play

import UIKit

let daysInMonth:[Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func isLeap(year:Int) -> Bool {
    let leapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
    return leapYear
}

func julianDate(year: Int, month: Int, day: Int) -> Int {
    let yearDuration: Int = Array(1900...year).filter{$0 % year != 0}.reduce(0, combine:{$0 + (isLeap($1) == true ? 366 : 365)})
    let monthDuration: Int = Array(1...month).filter{$0 % month != 0}.reduce(0, combine:{$0 + daysInMonth[$1]})
    let februaryCheck: Int = (isLeap(year) == true && month > 2 ? 1 : 0)
    return yearDuration + monthDuration + day + februaryCheck
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
