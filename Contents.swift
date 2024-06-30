import Foundation

//  класс Автомобиль
class Car {
    var brand: String
    var model: String
    var year: Int
    var enginePower: Int
    var fuelConsumption: Double
    var topSpeed: Int
    var luxuryLevel: String
    var reliabilityScore: Int
    
    init(brand: String, model: String, year: Int, enginePower: Int, fuelConsumption: Double, topSpeed: Int, luxuryLevel: String, reliabilityScore: Int) {
        self.brand = brand
        self.model = model
        self.year = year
        self.enginePower = enginePower
        self.fuelConsumption = fuelConsumption
        self.topSpeed = topSpeed
        self.luxuryLevel = luxuryLevel
        self.reliabilityScore = reliabilityScore
    }
    
    func getInfo() -> String {
        return "\(brand) \(model) (\(year)) - Мощность: \(enginePower) ЛС, Расход: \(fuelConsumption)л/100км, Макс. скорость: \(topSpeed)км/ч, Уровень роскоши: \(luxuryLevel), Надежность: \(reliabilityScore)"
    }
}

// классы моделей
class BMW: Car {
    init(model: String, year: Int, enginePower: Int, fuelConsumption: Double, topSpeed: Int, luxuryLevel: String, reliabilityScore: Int) {
        super.init(brand: "BMW", model: model, year: year, enginePower: enginePower, fuelConsumption: fuelConsumption, topSpeed: topSpeed, luxuryLevel: luxuryLevel, reliabilityScore: reliabilityScore)
    }
}

class Audi: Car {
    init(model: String, year: Int, enginePower: Int, fuelConsumption: Double, topSpeed: Int, luxuryLevel: String, reliabilityScore: Int) {
        super.init(brand: "Audi", model: model, year: year, enginePower: enginePower, fuelConsumption: fuelConsumption, topSpeed: topSpeed, luxuryLevel: luxuryLevel, reliabilityScore: reliabilityScore)
    }
}

class Mercedes: Car {
    init(model: String, year: Int, enginePower: Int, fuelConsumption: Double, topSpeed: Int, luxuryLevel: String, reliabilityScore: Int) {
        super.init(brand: "Mercedes", model: model, year: year, enginePower: enginePower, fuelConsumption: fuelConsumption, topSpeed: topSpeed, luxuryLevel: luxuryLevel, reliabilityScore: reliabilityScore)
    }
}

class Toyota: Car {
    init(model: String, year: Int, enginePower: Int, fuelConsumption: Double, topSpeed: Int, luxuryLevel: String, reliabilityScore: Int) {
        super.init(brand: "Toyota", model: model, year: year, enginePower: enginePower, fuelConsumption: fuelConsumption, topSpeed: topSpeed, luxuryLevel: luxuryLevel, reliabilityScore: reliabilityScore)
    }
}

// создание автомобилей
func createCars() -> [Car] {
    var cars = [Car]()
    cars.append(BMW(model: "M3", year: 2022, enginePower: 450, fuelConsumption: 10.0, topSpeed: 280, luxuryLevel: "High", reliabilityScore: 90))
    cars.append(Audi(model: "A8", year: 2020, enginePower: 340, fuelConsumption: 8.5, topSpeed: 260, luxuryLevel: "High", reliabilityScore: 88))
    cars.append(Mercedes(model: "E-Class", year: 2022, enginePower: 320, fuelConsumption: 9.8, topSpeed: 260, luxuryLevel: "Medium", reliabilityScore: 87))
    cars.append(Toyota(model: "Camry", year: 2020, enginePower: 200, fuelConsumption: 7.5, topSpeed: 210, luxuryLevel: "Low", reliabilityScore: 95))
    return cars
}

// организация гонки
func organizeRaces(cars: [Car]) {
    var cars = cars.shuffled()
    var winners = [Car]()
    
    while cars.count > 1 {
        let car1 = cars.removeFirst()
        let car2 = cars.removeFirst()
        let winner = race(car1: car1, car2: car2)
        winners.append(winner)
        print("""
        Участники:
        \(car1.getInfo())
        против
        \(car2.getInfo())
        
        Победитель: \(winner.getInfo())
        --------------------------------------------------
        """)
    }
    
    if winners.count > 1 {
        print("Финальная гонка:")
        organizeRaces(cars: winners)
    } else if let finalWinner = winners.first {
        print("""
        ==================================================
        Победитель турнира: \(finalWinner.getInfo())
        ==================================================
        """)
    }
}

// гонка между двумя автомобилями
func race(car1: Car, car2: Car) -> Car {
    // Сравнение автомобилей по мощности двигателя
    return car1.enginePower > car2.enginePower ? car1 : car2
}

let cars = createCars()
organizeRaces(cars: cars)
