//: Playground - noun: a place where people can play

import UIKit

let daysInMonth:[Int] = [
   0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
]

func isLeap(year:Int) -> Bool {
    let leapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
    return leapYear
}

func julianDate(year: Int, month: Int, day: Int) -> Int {
    let yearDuration: Int = Array(1900...year).filter{$0 % 1900 != 0}.reduce(0, combine:{$0 + (isLeap($1) != true ? 365 : 366)})
    let monthDuration: Int = Array(1...month).filter{$0 % month != 0}.reduce(0, combine:{$0 + daysInMonth[$1]})
    return yearDuration + monthDuration + day + (isLeap(year) == true && month > 2 ? 1 : 0)
}

func julianDate2(year: Int, month: Int, day: Int) -> Int {

//    let originalDate = (365*1900 + 1900/4 - 1900/100 + 1900/400 + (153*1 + 2)/5 + 1)
//    let julianDateDifference = (365*year + year/4 - year/100 + year/400 + (153*month + 2)/5 + day) - originalDate
    //let leapYearCheck = isLeap(year) ? 1 : 0

    let originalDate = (365*1900 + 1900/4 - 1900/100 + 1900/400 + (153*1 - 457)/5 + 1 - 306)
    let julianDateDifference = (365*year + year/4 - year/100 + year/400 + (153*month - 457)/5 + day - 306) - originalDate
    return julianDateDifference
}





julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

julianDate2(1960, month:  9, day: 28)
julianDate2(1900, month:  1, day: 1)
julianDate2(1900, month: 12, day: 31)
julianDate2(1901, month: 1, day: 1)
julianDate2(1901, month: 1, day: 1) - julianDate2(1900, month: 1, day: 1)
julianDate2(2001, month: 1, day: 1) - julianDate2(2000, month: 1, day: 1)

isLeap(2000)
isLeap(1900)
isLeap(2000)


let leapYearCheck = isLeap(2001) ? 1 : 0

//myBool = str1 ? true : false
//let leapYearCheck = isLeap(year) ? 1 : 0
//func reduce<U>(initial: U, combine: (U, T) -> U) -> U

let sum:Int = [1, 2, 3, 4, 5].reduce(0, combine: { $1 + $0 + 1})

let evenSum:Int = Array(1...3).filter { (number) in number % 2 == 0 }.reduce(0) { (total, number) in total + number }

let smallSum:Int = Array(1...1).reduce(0, combine: { $1 + $0})

evenSum
sum
smallSum



julianDate2(1908, month: 3, day: 4)
//daysInMonth[2]

(2 % 3 != 0)
