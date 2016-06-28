//: Playground - noun: a place where people can play

import UIKit
import Foundation

let immutableString = "hello playround"
var str = "Hello, playground"

str = "another string"

var myInt = 42
let myConstant = 50

let implicitDouble = 70.0
let explicitDouble: Double = 70

let label = "the width is "
let width = 94
let widthLabel = label + String(width)

String(94)

let apples = 3
let oranges = 5
var appleSummary = "I have \(apples) apples."
appleSummary = "I have \(oranges) oranges."

var aFloat : Float

var shoppingList = ["catfish", "water", "tulips", "blue paint"];
shoppingList.append("toothpaste")

var specificList: Array<String> = ["catfish", "water", "tulips", "blue paint"];
shoppingList.append("toothpaste")

var mutableList: NSMutableArray = ["catfish", "water", "tulips", "blue paint"];
shoppingList.append("toothpaste")


var hybridList = ["catfish", "water", "tulips", "blue paint",49];
hybridList.append("toothpaste")
hybridList.append(47)

var copyList = shoppingList

var occupation = [
    "malcom": "captain",
    "kalyee": "machanic"
]



var occupation2: Dictionary<String,String> = [
    "malcom": "captain",
    "kalyee": "machanic"
]

occupation2["Jayne"] = "Public Relations"



//Modern Loop
//(k:String, v:String) -> String in

//Modern Version of For Loop
var occupationNames = occupation2.map {(k:String, v:String) -> String in
    return k
}

var occupationNameShort = occupation2.map { return $0.0 }

occupationNames
occupationNameShort

//var occupationNameShort2 = occupation2.map { return $0.0 }.map {$0; return "blah"}
//occupationNameShort2


var r = 50...100
var g = r.generate()
g.next()

var tuple1 = (1,2)
tuple1.0
tuple1.1

var tuple2 = (first:"van", last:"Simmons")
tuple2.0
tuple2.last

for (k,v) in occupation {
     print ("\(k),\(v)")
}


//Think Function (->)

func doubler(x:Int) -> Int {
    return x*2
}

doubler(4)

func progression(v:Int,f:Int->Int) ->Int {
    return f(v)
}

progression(4,f:doubler)

var tf = false
tf = true

var emptyArr = [[]]
var arrArr = [[true,false]]

var specificArray:Array<Array<Bool>> = [[true]]

var specificArray2:Array<Dictionary<Int,Bool>> = [[1:true]]


//Functions can be variables

//closure is a anyonomus function
var closure = { (x:Int) -> Int in
    return x*2
}

closure(6)

progression(6, f: closure)

//Same as Above
progression(6) {(x:Int) -> Int in
    return x*2
}

//Same as
progression(6, f:{(x:Int) -> Int in
    return x*2
})


//----------------------------------------
//This String can either be a string or nothing - In Homework
var n:String? = nil

var t:Int? = nil

//Doubler NEEDS to be an Int
//doubler(t)

var optionalN:Int? = 14

//
var implicitOptionalN:Int! = 12

if let n = optionalN {
        let doubleN = doubler(n)
}

doubler(implicitOptionalN)


//----------------------------------------
//Drop a button in the Viewcontroller. Then ctrl grab the button and drag it to uiviewcontroller
