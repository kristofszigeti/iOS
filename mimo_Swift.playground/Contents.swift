import Cocoa

var greeting = "Hello, playground"

// Functions
func userAge(number: Int) -> String {
 let age = "User age: \(number)"
 return age
}

print(userAge(number: 22))

func giveMeTen() -> Int {
    return 10
}

print(giveMeTen())


func addGreeting(user: String) -> String {
    let greeting = "Greeting " + user
    return greeting
}

//let result = addGreeting(user: "Mari")
//print(result)


func addTen(number: Int) -> Int {
 let addedTen = 10 + number
 return addedTen
}

print(addTen(number: 20))


func signUp(user: String) -> String {
    let status = user + " Signed up"
    return status
}

let result = signUp(user: "Desmond")

func displayAirDate(year: Int) -> String {
    return "TV show aired in: \(year)"
}
let text = displayAirDate(year: 1990)
print(text)


func display(firstName: String, lastName: String) {
    print(firstName, lastName)
    print(firstName + " " + lastName)
}

display(firstName: "Alex", lastName: "Turner")

func addPrefix(prefix: String, word: String) -> String {
    return prefix + word
}
let newWord = addPrefix(prefix: "re", word: "do")
print(newWord)

func sumTotal(price: Double, tax: Double) {
 print(price + tax)
}

sumTotal(price: 1000, tax: 250)


func isFreezing(temperature: Int) -> Bool {
  return temperature < 0
}

let freezing = isFreezing(temperature: -3)
print(freezing)


func calculateSum(a: Int, b: Int) -> Int {
 return a + b
}

func calculateDifference(a: Int, b: Int) -> Int {
 return a - b
}

let sum = calculateSum(a: 30, b: 11)
let difference = calculateDifference(a: 30, b:11)

print(sum)
print(difference)

func displayName(name: [String]) {
    print(name[0])
}

func displayAlias(name: [String]) {
    print(name[1])
}

let fullName = ["Clark Kent", "Superman"]
displayName(name: fullName)
displayAlias(name: fullName)

func displayNames(_names: [String]) {
  print(_names)
}

let students = ["Laurel", "Yanni"]
displayNames(_names: students)

func displayNamesCount(names: [String]) {
    print(names.count)
}

let _students = ["Laurel", "Yanni"]
displayNamesCount(names: _students)


func getListOfNames(namesList: [String]) -> String {
   return namesList[0] + ", " + namesList[1]
}

let studentsList = ["Vera", "Rubin"]
let list = getListOfNames(namesList: students)
print(list)


// Classes
class Computer {
 let size: String
 let storage: String

 init(size: String, storage: String) {
   self.size = size
   self.storage = storage
 }

 func printSpecs() {
   print("Display size: \(size)")
   print("Storage size: \(storage)")
 }
}

let lowSpec = Computer(size: "13", storage: "256GB")
let highSpec = Computer(size: "27", storage: "1TB")

print("Low Spec Computer:")
lowSpec.printSpecs()

print("High Spec Computer:")
highSpec.printSpecs()


//class VirtualPet {
//    let waggingTail = true
//    let color = "brown"
//}
//
//let skippy = VirtualPet()
//print(skippy.waggingTail)


class VirtualPet {
  let color = "brown" // saját változója az osztály ezen szintjének

  func bark() {
    print("Bark")
  }
}

let rocky = VirtualPet()
print(rocky.color)
rocky.bark()


class VirtualPet3 {
  let color: String

  init(color: String) {
    self.color = color
  }
}

let rocky3 = VirtualPet3(color: "red")


class VirtualPet2 {
  let color: String
  let legs: Int

    init(color: String,legs: Int) {
    self.color = color
    self.legs = legs
  }
}

let rocky2 = VirtualPet2(color: "red", legs: 4)
print(rocky2.color)
print(rocky2.legs)


class BookSeries {
  let name: String
  let books: [String]
  let numBooks: Int

  init(name: String, books: [String]) {
    self.name = name
    self.books = books
      self.numBooks = books.count // after count built-in method indicating function by () is not necessary
  }

  func printName() {
    print(name)
  }

  func printBooks() {
    print(books)
  }
}

let hg = BookSeries(name: "Hunger Games", books: ["The Hunger Games", "Catching Fire", "Mockingjay"])
hg.printBooks()
print(hg.numBooks)
