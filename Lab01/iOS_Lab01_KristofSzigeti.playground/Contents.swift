import Cocoa
//
//var greeting = "Hello, playground"
//

class GameCharacter: NSObject {
    var name: String
    var level: Int
    var healthPoint = 100
    var isDead: Bool { // computed property
        get { // ilyen esetben a 'get' el is hagyható
            return healthPoint <= 0 // visszatér azzal, hogy a karakter él-e még; 'true', ha elveszítette az összes életerejét, 'false', ha még van 'hP'-ja
        }
    }
    var power: Int { // computed property 'get' nélkül
        return level * 10 // visszatér a karakter támadóerejével
    }
    // property-k inicilializálása nélkül hibát kapunk
    // a swift ezt kötelezően előírja class esetén (struct esetén minden ok <- memberwise initializer)
    // azonban, ha a minden változónak adunk kezdeti értéket és nincs 'init()', akkor a swift létrehoz egy 'default initializer'-t
//    var build = "Rogue" // de statikus változót tudunk neki adni gond nélkül
    
    init?(name: String, level: Int) {
        if level < 0 || level >= 100 {
        return nil // 'valueless state'
        }
        self.name = name // Fontos kiemelni, hogy a self általában elhagyható, azonban itt most mind az inicializáló paramétereinek, mind az osztály property-jeinek ugyanaz a neve, ezért muszáj kiírni, ha a property-kre szeretnénk hivatkozni!
        self.level = level
        // Módosítsuk az inicializálót oly módon, hogy ha a megadott szint nem esik értelmes határok közé, akkor ne jöjjön létre az objektum (vagyis térjünk vissza 'nil'-el). Ezt a mechanizmus (vagyis, hogy init?-el definiálunk egy inicializálót) 'failable initializer'-nek nevezik.
        super.init()
    }
}

let hero1 = GameCharacter(name: "Force Chainer", level: 1) //inicializálók és függvények hívásánál alapesetben minden paraméter nevét ki kell írni
    // mivel hero1-et lettel definiáltuk, ez egy konstans és nem változtatható az értéke (azonban a hivatkozott objektumnak ettől még módosíthatjuk a property-jeit)
    // type inference = the ability to automatically deduce, either partially or fully, the type of an expression at compile time
    // A Swift statikusan típusos nyelv: minden változónak van típusa és a definiálásuk után ez a típus nem is változhat. A változók típusát azonban a legtöbb esetben nem kötelező explicit megadni, mert a fordító kitalálja a változó/konstans kezdeti értékéből. Ezt a mechanizmust hívjuk type inference-nek.

let hero2 = GameCharacter(name: "Wrap Binder", level: 3)
// hero2.level = 30 // HIBA! -> az opcionális típusokon (<-init?) közvetlenül nem hívhatjuk meg a becsomagolt objektum műveleteit, csak ha előtte "kicsomagoljuk" őket!

// Force unwrap
if hero2 != nil { // kezeli a határesetet és 'nem ijed meg'
    hero2!.level = 30 // force unwrap
}
// Ha 'nil' értékű Optionalt (<-init) próbálunk kicsomagolni, az alkalmazás el fog szállni!

// Optional Chaining
hero2?.level = 32 // 'Optional chaining' = ha az osztály példánya 'nil', akkor nem hajtódik végre

// Optional Binding
//if let unwrappedHero = hero2 {
//  unwrappedHero.level = 30
//}

//guard let unwrappedHero = hero2 else { return }
//unwrappedHero.level = 30

// ÖRÖKLÉS ÉS CSATOLÁS
class Hero: GameCharacter { // öröklünk a Gamecharacter parent-ből, de a 'Hero'-nak lehet fegyvere, aki, így erősebb
    enum WeaponType { // A fegyvert egy 'enum'-mal jelképezzük!
        case laserCannon
        case spoon
        case danceOfKnives
        case cataclysm
        case fireBlast
    }
    var weapon: WeaponType? // optional weapon
    override var power: Int { // felülírjük a parent class power-jét
        var extraPower = 0 // a fegyverből származó többleterő kezdeti értéke
        if let unwrappedWeapon = weapon {
            switch unwrappedWeapon {
            case .laserCannon: // maga az eset van definiálva
                extraPower = 100 // és ezen belül hozunk létre "hozomány", "következményét" az esetnek
            case .spoon:
                extraPower = -1
            case .danceOfKnives:
                extraPower = 400
            case .cataclysm:
                extraPower = 50
            case .fireBlast:
                extraPower = 30
            }
        }
        return super.power + extraPower
    }
// Swiftben a metódusok és a property-k (legyen akár stored akár computed property) egyaránt felüldefiniáhatók a leszármazott osztályokban (kivéve ha finalként vannak megjelölve). Felüldefiniáláskor azonban az override kulcsszó kiírása kötelező.
}
    
// GENERIKUS TÁROLÓK, METÓDUSOK ÉS OSZTÁLYHIERARCHIÁK
class Team {
    private var members = [GameCharacter]() // Private access restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration. https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/
    //  tehát nem férünk hozzá később a members tömbhöz
    func add(_ member: GameCharacter) { // hozzáfűzűnk egy (már létrehozott) karaktert a tömb végére
        members.append(member)
        print("'\(member.name)' hozzáadva a csapathoz!")
        print("\(members.count) karakter szerepel a csapatban")
    }
    
    func printMembers() {
        for member in members {
            print("\(member.name): LVL \(member.level)")
            sleep(2)
        }
    }
    func funcprintMembers() {
        members.forEach {print($0.name)}
        }
    func has(member: GameCharacter) -> Bool {
        return members.contains {$0 == member}
    }
    
    func checkMember(member: GameCharacter) {
        if self.has(member: member) {
            print("\(member.name) a csapatban van!")
        }
        else {
            print("\(member.name) még nem csapattag!")
            }
    }
    func getMembers() -> [GameCharacter] {
        return members
    }
}
// a csapatba ('Team') tartozó karaktereket (példányok) a 'members' property tárolja, ami egy tömb (pl.: lista) és 'GameCharacter' példányokat tartalmaz. kezdeti értéke egy üres tömb '[...]()'

// Csináljunk egy csapatot és adjuk hozzá a hőseinket!
// Figyeljük meg, hogy itt is optional force unwrap-et használunk, mivel az add metódus 'nem' optional paramétert vár.

// PROTOKOLLOK
// Írjunk egy protokollt (más nyelvekben interfész), mely tartalmazza a "harcoláshoz" szükséges metódus és property sablonokat. Lényegében azt szeretnénk elérni, hogy minden olyan osztály, mely megvalósítja ezt a protokollt, részt vehessen egy csatában. Valamint készítsünk elő egy metódust, amivel a karakternek ki tudjuk írni az aktuális életét.
class Monster {
    var name: String
    var headCount: Int
    var power: Int {
        return headCount * 20
    }
    var isDead: Bool { // computed property
        return headCount <= 0 // visszatér azzal, hogy a szörnyeteg él-e még; 'true', ha elveszítette az összes életerejét, 'false', ha még van 'feje'-ja
    }
    init?(name: String, headCount: Int) {
        self.name = name // Fontos kiemelni, hogy a self általában elhagyható, azonban itt most mind az inicializáló paramétereinek, mind az osztály property-jeinek ugyanaz a neve, ezért muszáj kiírni, ha a property-kre szeretnénk hivatkozni!
        self.headCount = headCount
        // Módosítsuk az inicializálót oly módon, hogy ha a megadott szint nem esik értelmes határok közé, akkor ne jöjjön létre az objektum (vagyis térjünk vissza 'nil'-el). Ezt a mechanizmus (vagyis, hogy init?-el definiálunk egy inicializálót) 'failable initializer'-nek nevezik.
    }
}

protocol Fightable {
    var isDead: Bool { get }
    var power: Int { get }
    var name: String { get }
    
    func takeDamage(from enemy: Fightable)
    func printHealth()
}

extension GameCharacter: Fightable {
    func takeDamage(from enemy: Fightable) {
        let attackRating = Double.random(in: 0...10) / 10
//        print(attackRating)
        let effectiveDamage = Int(Double(enemy.power) * attackRating)
        print("\n\(name) took \(enemy.power) damages, which cause \(effectiveDamage) from \(enemy.name)")
        sleep(2)
        
        healthPoint -= effectiveDamage // azonos típusra kell hozni!
        
    }
    func printHealth() {
        print("\(name): \(healthPoint) ❤️ \n")
    }
}

extension Monster: Fightable {
    func takeDamage(from enemy: Fightable) {
        print("\n\(name) took \(enemy.power) damages from \(enemy.name)")
        sleep(2)
        if Int.random(in: 0...1) == 1 {
                headCount -= 1
            print("One of the heads is down!")
        } else {
            print("This monster is dodging!")
            sleep(2)
        }
    }
    func printHealth() {
        print("\(name) has \(headCount) head(s) left.")
    }
}

class Arena {
    var players: [Fightable]
    
    init(with players: [Fightable]) {
        self.players = players
    }
    func startBrawl() {
        print("\nItt láthatjuk a hősöket!")
        heroes.printMembers()
        print("\nKezdődjön a küzdelem!")
        
        while players.count > 1 {
            sleep(4)
            // Keverjük össze a tömb elemeit, hogy összecsapásonként más legyen az első és utolsó elem. Ők lesznek az akutális ütközetben összecsapó felek.
            players.shuffle()
            
            if let firstPlayer = players.first, let secondPlayer = players.last {
                // Az egyik játékos kapjon ütést a másiktól és írjuk ki az életét utána.
                firstPlayer.takeDamage(from: secondPlayer)
                firstPlayer.printHealth()
                
                // Ha az ütést kapott karakter elveszített az összes életerejét, akkor töröljük a listából.
                if firstPlayer.isDead {
                    print("☠️ \(firstPlayer.name) died. ☠️")
                    players.removeFirst()
                    
                }
            }
        }
        // Ha már csak a győztes szerepel a játékosok között, akkor írjuk ki a nevét.
        if players.count == 1, let winner = players.first {
            print("There is nobody left! \n👑 The winner is \(winner.name)! 👑")
        }
    }
}

// KARAKTEREK ÉS HŐSÖK LÉTREHOZÁSA
let heroes = Team()
//heroes.printMembers()
heroes.add(hero1!)  // force unwrap, mert az add metódus nem optional paramétert vár
//heroes.checkMember(member: hero1!)
heroes.add(hero2!)
//heroes.checkMember(member: hero2!)

let hero3 = GameCharacter(name: "Paladin", level: 21)
let hero4 = Hero(name: "Druid", level: 44)
hero4?.weapon = .cataclysm // itt adunk neki fegyvert az egyik enum eset hozzárendelésével
let hero5 = Hero(name: "Hero", level: 55)
hero5?.weapon = .spoon
let hero6 = Hero(name: "Sorcerer", level: 12)
hero6?.weapon = .fireBlast
let hero7 = Hero(name: "Rogue", level: 4)
hero7?.weapon = .danceOfKnives

heroes.add(hero3!)
//heroes.checkMember(member: hero3!)
heroes.add(hero4!)
//heroes.checkMember(member: hero4!)
heroes.add(hero5!)
//heroes.checkMember(member: hero5!)
heroes.add(hero6!)
heroes.add(hero7!)


// A HARC
// Arena 1
//let arena = Arena(with: [hero1!, hero2!, hero3!, hero4!, hero5!])
//arena.startBrawl()

// Arena 2
let arena2 = Arena(with: heroes.getMembers())
arena2.startBrawl()

let monster1 = Monster(name: "Diablo", headCount: 1)
let monster2 = Monster(name: "Hydra", headCount: 5)
let monster3 = Monster(name: "Two-headed Red Dragon", headCount: 2)

// Arena 3
let arena3 = Arena(with: [hero5!, hero6!, hero7!, monster1!, monster2!, monster3!])
arena3.startBrawl()
