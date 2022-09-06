//: [Previous](@previous)

import Foundation




let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")

let date = Date()

let write = Date(timeInterval: -86400 * 270 + 86400 * 16 ,since: date)
let write2 = Date(timeInterval: -(86400 * 270) + 86400 * 18  ,since: date)
//let write = Date(timeInterval: 86400 * 118 , since: date)
print(write)
print(write2)
let currentDateComponent = Calendar.current.dateComponents([.day, .weekOfYear], from: write)
let registeredeDateComponent = Calendar.current.dateComponents([.day, .weekOfYear], from: write2)
print(currentDateComponent)
print(registeredeDateComponent)
if currentDateComponent.day == registeredeDateComponent.day {
    print(1)
} else if currentDateComponent.weekOfYear == registeredeDateComponent.weekOfYear {
    print(2)
} else {
    print(3)
}


    






//: [Next](@next)
