////
////  main.swift
////  SwiftPractice
////
////  Created by kristof on 2025. 09. 19..
////
//
import Foundation
////
////print("Hello, World!")
print("Gondoltam egy számra 1 és 100 között!")
let secretNumber = Int.random(in: 1...100); // let!
//
//
////guard let line = readLine(), !line.isEmpty else {
////    print("Nem kaptam bemenetet.")
////    return
////}
////initials
var attempts = 0
var success = false
//
//// Input
/// loop, hogy fusson az ellenőrzésf
while success == false { // ha siker, átállítom
    print("Adj meg egy tippet: ")
    guard let line = readLine(), !line.isEmpty else { // Enter-rel előidézhető az üres input, String? -> +guard!
        print("Nem adtál meg semmit! Így nem tudunk játszani.")
        continue
    }
    if line.lowercased() == "q" { // q esetén a readline() megszakítja a loop-ot és továbblép a következő feladatra
        print("Kilépés")
        break
    }
    guard let guess = Int(line) else { // ha nem szám (integer), akkor kéri, hogy szám legyen
        print("Adj meg egy számot inkább!")
        continue
    }
    // kiértékelési elágazások
    // találat
    if guess == secretNumber {
        print("Ezt eltaláltad! \(attempts) kísérleten belül.");
        success = true;
        break
    // nagyobb a tipp, mint a kisorsolt szám
    } else if guess > secretNumber {
        print("Túl nagy");
        attempts += 1;
    // kisebb...
    } else {
        print("Túl alacsony")
        attempts += 1;
    }
}

// Output
print("Kulka")


// Webshop
// közös interface létrehozása, aminek minden terméknek meg kell felelnie: ez a protokoll (mint a arénabelépő is volt
// protokoll = szabályrendszer
protocol Product {
    // var variable: type { get }-olvasás vagy { get set }-olvasás+írás
    var name: String { get }; // string típusú változó (var) 'name', mivel csak get ezért olvasni lehet, de a set hiánya miatt írni nem
    var price: Double { get }; // double, mint ár
    var id: UUID { get }; // id, mint egyedi azonosító UUID
    
    func productInfo() -> String // a protokollon belül még nem adjuk meg, hogy mit adjon vissza, de extensionnel kiegészíthetjük (felül is írhatjuk), vagy a példányosításnál (Book, Laptop), egyedien
}

struct Book: Product { // struct: adattárolók létrehozására használjuk a protokol alapján
    let id: UUID = UUID() //  meghívtuk a UUID() funkciót, ami létrehozza az egyedi azonosító byte-okat ( 4random byte)
    let name: String
    let price: Double
    let author: String
    
    func productInfo() -> String {
        return "Könyv: \(name), szerző: \(author)"
    }
}

struct Laptop: Product {
    let id: UUID = UUID()
    let name: String
    let price: Double
    let cpu: String
    
    func productInfo() -> String {
        return "Laptop: \(name), CPU: \(cpu)"
    }
}
// felsorolás (enumeráció), néhány előre meghatározott értékhez, hogy mást ne vehessen fel
enum Discount { // ezt 'Discount' kell meghívni a változóban eltároláshoz
    // case none
    case Percentage (Double) // típust rendelünk az esethez, pl % (double)
    case FixAmount (Double) // rögzített érték (double)
}

class Cart { // tárolja a Product-okat és számolja a fizetendő összeget
    private var items: [any Product] = [] // bármelyik Product-protokollnak megfelelő elem egy tömbben tárolva
    private var discountedTotal: Double? = nil // kedvezmények halmozhatósága miatt opcionális, kezdeti nil-el
    
    func addToCart(_ product: any Product) { // '_' nincs label -> híváskor nem kell nevet írni
        items.append(product)
    }
    
    func removeFromCart(id: UUID) -> Bool { // a firstIndex boolean-t ad vissza, hogy talált-e a megadott változóhoz UUID-t a tömbben
        if let itemId = items.firstIndex(where: { $0.id == id }) { // $0 a változó maga a struct és létrehozás után; az itemId, csak egy index-szám, mint integer
            let removedItem = items[itemId] // így lesz Product
            items.remove(at: itemId)
            print("Sikerült törölni a \(removedItem.name) terméket.") // aminek van name-je
            return true // mivel boolean-t kérünk vissza. de csak jelzi, hogy OK
        }
        print("Nincs ilyen termék a kosaradban.")
        return false // ha nincs ilyen azonosító
    }
    
    func totalPrice(discount: Discount? = nil) -> Double { // opcionális
        // optional value + így halmozható a kedvezmény
        var sumPrice = discountedTotal ?? items.reduce(0.0) {
            partial, product in partial + product.price
        }
        
        guard let discount = discount else {
            discountedTotal = sumPrice
            return round(sumPrice)
        }
        
        switch discount {
        case .Percentage(let percent):
            // valótlan értékek kezelése (-%, >100%)
            let p = min(max(percent, 0.0), 100.0)
            sumPrice = sumPrice * (1.0 - p / 100.0)
//          return round(max(sumPrice, 0.0))
            
        case .FixAmount(let amount):
            let a = max(amount, 0.0)
            sumPrice = sumPrice - a
//          return round(max(sumPrice, 0.0))
        }
        
        discountedTotal = sumPrice
        return round(max(sumPrice, 0.0))
    }
    
    func printItems() {
        if items.isEmpty {
            print("üres a kosarad")
        } else {
            print("A kosaradban \(items.count) db termék van")
            for item in items {
                print("- \(item.productInfo())")
            }
        }
    }
}

// példányosítás
// termékek objektumok létrehozása
let lowSpecLaptop = Laptop(name: "netbuk", price: 10000, cpu: "alig valami")
let book1 = Book(name: "Gyűrűk Ura", price: 3000, author: "J.R.R Tolkien")

print(book1.productInfo()) // kiíratjuk az értéket, amit visszaad
// kosár osztály
let myCart = Cart()

// enum
let tenPercentDiscount = Discount.Percentage(10) // line95

myCart.addToCart(book1) // az osztály függvény meghívása
myCart.printItems() // van print benne, így csak meg kell hívni
myCart.addToCart(lowSpecLaptop)
myCart.printItems()
print(myCart.totalPrice()) // teljes ár, line117 miatt paraméter nélkül is meghívható
print(myCart.totalPrice(discount: .FixAmount(1000.0)))
print(myCart.totalPrice(discount: tenPercentDiscount))
print(myCart.totalPrice(discount: .FixAmount(1000.0)))
myCart.removeFromCart(id: book1.id)
myCart.printItems() // a book1 nélküli kosár

