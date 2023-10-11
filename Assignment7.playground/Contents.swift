import Foundation

/*
 შევქმნათ Class-ი SuperEnemy with properties: String name, Int hitPoints (ანუ სიცოცხლის რაოდენობა).
 სურვილისამებრ დაამატებ properties რომელიც მას აღწერს.
 */

class SuperEnemy {
    let name: String
    let isEvil: Bool
    var hitPoints: Int
    
    init(name: String, hitPoints: Int, isEvil: Bool) {
        self.name = name
        self.isEvil = isEvil
        self.hitPoints = hitPoints
    }
}

/*
 შევქმნათ Superhero Protocol-ი.
 შემდეგი get only properties: String name, String alias, Bool isEvil და დიქშენარი (dictionary) superPowers [String: Int], სადაც String-ი არის სახელი და Int არის დაზიანება (damage).
 Method attack, რომელიც მიიღებს target SuperEnemy-ის და დააბრუნებს (return) Int-ს ანუ დარჩენილ სიცოცხლე.
 Method performSuperPower, რომელიც მიიღებს SuperEnemy-ის და დააბრუნებს (return) Int-ს, აქაც დარჩენილ სიცოცხლე.
 */

protocol Superhero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get }
    
    func attack(target: SuperEnemy) -> Int
    
    mutating func performSuperPower(target: SuperEnemy) -> Int
}

/*
 Superhero-ს extension-ი გავაკეთოთ სადაც შევქმნით method-ს რომელიც დაგვი-print-ავს ინფორმაციას სუპერ გმირზე და მის დარჩენილ superPower-ებზე.
 */

extension Superhero {
    func printSuperheroInfo(_ superhero: Superhero) {
        print("Superhero Name: \(name)")
        print("Superpower Left:")
        for (superPower, damage) in superPowers {
            print("\(superPower): \(damage)")
        }
    }
}

/*
 შევქმნათ რამოდენიმე სუპერგმირი Struct-ი რომელიც ჩვენს Superhero protocol-ს დააიმპლემენტირებს მაგ:
 struct SpiderMan: Superhero და ავღწეროთ protocol-ში არსებული ცვლადები და მეთოდები.
 attack მეთოდში -> 20-იდან 40-ამდე დავაგენერიროთ Int-ის რიცხვი და ეს დაგენერებული damage დავაკლოთ SuperEnemy-ს სიცოცხლეს და დარჩენილი სიცოცხლე დავაბრუნოთ( return).
 performSuperPower-ს შემთხვევაში -> დიქშენერიდან ერთ superPower-ს ვიღებთ და ვაკლებთ enemy-ს (სიცოცხლეს ვაკლებთ). ვშლით ამ დიქშენერიდან გამოყენებულ superPower-ს. გამოყენებული superPower-ი უნდა იყოს დარანდომებული. დარჩენილ enemy-ს სიცოცხლეს ვაბრუნებთ (return).
 */

struct SpiderMan: Superhero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
    
    func attack(target: SuperEnemy) -> Int {
        let randomDamage = Int.random(in: 20...40)
        target.hitPoints -= randomDamage
        return target.hitPoints
    }
    
    mutating func performSuperPower(target: SuperEnemy) -> Int {
        if superPowers.isEmpty {
            attack(target: target)
            print("No superpowers left, starting to attack")
            return target.hitPoints
        }
        if let randomElemet = superPowers.randomElement() {
            let randomDamage = randomElemet.value
            target.hitPoints -= randomDamage
            superPowers.removeValue(forKey: randomElemet.key)
        }
        return target.hitPoints
    }
}

struct IronMan: Superhero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
    
    func attack(target: SuperEnemy) -> Int {
        let randomDamage = Int.random(in: 20...40)
        target.hitPoints -= randomDamage
        return target.hitPoints
    }
    
    mutating func performSuperPower(target: SuperEnemy) -> Int {
        if superPowers.isEmpty {
            attack(target: target)
            print("No superpowers left, starting to attack")
            return target.hitPoints
        }
        if let randomElemet = superPowers.randomElement() {
            let randomDamage = randomElemet.value
            target.hitPoints -= randomDamage
            superPowers.removeValue(forKey: randomElemet.key)
        }
        return target.hitPoints
    }
}

/*
 შევქმნათ class SuperhroSquad,
 რომელიც ჯენერიკ Superhero-s მიიღებს. მაგ: class SuperheroSquad<T: Superhero>.
 შევქმნათ array სუპერგმირების var superheroes: [T].
 შევქმნათ init-ი.
 შევქმნათ method რომელიც ჩამოგვითვლის სქვადში არსებულ სუპერგმირებს.
 
 class SuperheroSquad არ იყოს Generic. და ცვლადი superheroes  [T]-ს მაგივრად იყოს [Superhero]-ს ტიპის.
 */

let enemy = SuperEnemy(name: "N.G", hitPoints: 100, isEvil: true)
let spiderMan = SpiderMan(name: "Peter Parker", alias: "N/A", isEvil: false, superPowers: ["SpiderSense": 15, "Web-Slinging": 20, "Martial Arts": 25])
let ironMan = IronMan(name: "Tony Stark", alias: "N/A", isEvil: false, superPowers: ["Advanced Weaponry": 25, "Superhuman strength": 30, "Powered armor suit": 35])

var mySquad = SuperheroSquad()
mySquad.superheroes.append(spiderMan)
mySquad.superheroes.append(ironMan)

class SuperheroSquad {
    var superheroes: [Superhero]
    
    init() {
        superheroes = []
    }
    
    func printSuperheroes() {
        for superhero in superheroes {
            print("Superhero: \(superhero.name)")
        }
    }
}

/*
  ამ ყველაფრის მერე მოვაწყოთ ერთი ბრძოლა.
  შევქმნათ method simulateShowdown. ეს method იღებს სუპერგმირების სქვადს და იღებს SuperEnemy-ს.
  სანამ ჩვენი super enemy არ მოკვდება, ან კიდევ სანამ ჩვენ სუპერგმირებს არ დაუმთავრდებათ სუპერ შესაძლებლობები გავმართოთ ბრძოლა.
  ჩვენმა სუპერ გმირებმა რანდომად შეასრულონ superPowers, ყოველი შესრულებული superPowers-ი იშლება ამ გმირის ლისტიდან. თუ გმირს დაუმთავრდა superPowers, მას აქვს ბოლო 1 ჩვეულებრივი attack-ის განხორციელება (ამ attack განხორიციელება მხოლოდ ერთხელ შეუძლია როცა superPowers უმთავრდება).
 */

func simulateShowdown(squad: SuperheroSquad, enemy: SuperEnemy) {
    for var superhero in squad.superheroes {
        superhero.performSuperPower(target: enemy)
        print("\(superhero.name) has used a Superpower. \(enemy.name) has \(enemy.hitPoints) remaining")
        superhero.printSuperheroInfo(superhero)
        while superhero.superPowers.isEmpty == false && enemy.hitPoints == 0 {
            superhero.performSuperPower(target: enemy)
            print("\(superhero.name) has used a Superpower. \(enemy.name) has \(enemy.hitPoints) remaining")
        }
        superhero.attack(target: enemy)
        print("\(superhero.name) has attacked. \(enemy.name) has \(enemy.hitPoints) remaining")
    }
}

simulateShowdown(squad: mySquad, enemy: enemy)

if enemy.hitPoints <= 0 {
    print("Superheroes win!")
} else {
    print("SuperEnemy wins!")
}
