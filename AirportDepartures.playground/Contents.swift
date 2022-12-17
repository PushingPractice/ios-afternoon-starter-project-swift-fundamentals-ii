import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
case enRoute
case scheduled
case canceled
case delayed
}

struct Airport {
    let name: String

}

struct Flight {
    var date: Date?
    var terminal : String?
    var flightStatus: FlightStatus
    
     
}

class DepatureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport
    
    
    // Initializer - The way of taking in external values and giving them to the class properties (name, address, etx. above) to be their values.
    // Initializers in swift are basically functions
    init(depatureFlights: [Flight],  currentAirport: Airport) {
        self.departureFlights = depatureFlights
        self.currentAirport = currentAirport
    }
    
    func addflights(flight: Flight) {
        departureFlights.append(flight)
    }
    
    func alertPassengers() {
        for flight in departureFlights {
            if flight.terminal == nil {
                print("TBD")
            } else {
                switch flight.flightStatus {
                case .scheduled:
                    print("Your flight is scheduled to depart at \(flight.date ?? makeDate(year: 2022, month: 4, day: 5, hr: 4, min: 5, sec: 4)) from terminal: \(flight.terminal ?? "TBD")")
                case .enRoute:
                   print( "Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon.")
                case .canceled:
                   print( "We're sorry your flight to (city) was canceled, here is a $500 voucher")
                case .delayed:
                   print( "Sorry for the delay. Your flight will soon be updated!")
                }
            }
        }
    }
}


//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
    var flight1 = Flight(date: Date(),terminal: "4", flightStatus: .scheduled)
    var flight2 = Flight(date: Date(),terminal: "3", flightStatus: .scheduled)
    var flight3 = Flight(date: Date(),terminal: "81" ,flightStatus: .scheduled)
    let bushInt = Airport(name: "Bush International")
    let depatureBoard = DepatureBoard(depatureFlights: [], currentAirport: bushInt)


    
depatureBoard.addflights(flight: flight1)
depatureBoard.addflights(flight: flight2)
depatureBoard.addflights(flight: flight3)
flight2.terminal = nil
flight1.flightStatus = .canceled
flight1.date = nil


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepatureBoard) {
    
    for flight in departureBoard.departureFlights {
            print(flight)
        }
    }

printDepartures(departureBoard: depatureBoard)




//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDepartures2(departureBoard: DepatureBoard) {
    for flight in departureBoard.departureFlights {
        guard let date = flight.date,
              var terminal = flight.terminal else { return }
        print("Destination: \(date), Airline: Bush Int, termianl: \(terminal), Flight Status: \(flight.flightStatus.rawValue)")
    }
}
printDepartures2(departureBoard: depatureBoard)

func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
    var calendar = Calendar(identifier: .gregorian)
    // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
    return calendar.date(from: components)!
}
//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
depatureBoard.departureFlights[0].flightStatus = .delayed
depatureBoard.alertPassengers()


//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    var answer: Double = 0.0
    
    var bagCost = 25 * Double(checkedBags)
    
    var distancePrice = Double(distance) * 0.10
    var farePrice = bagCost + distancePrice
    
    answer = Double(farePrice) * Double(travelers)
    
    return answer
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
