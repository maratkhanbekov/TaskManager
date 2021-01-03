import UIKit

struct Person: Codable {
    let name: String
    let age: Int
    let isDeveloper: Bool
}


protocol ResponsePersonsHandler {
    var next: ResponsePersonsHandler? { get set }
    func decodeDataToPersons(from data: Data) -> [Person]?
}

class DataToPersonHander1: ResponsePersonsHandler {
    var next: ResponsePersonsHandler?
    func decodeDataToPersons(from data: Data) -> [Person]? {
        let decoder = JSONDecoder()
        
        struct PersonRootDecodableType1: Codable {
            let data: [Person]
        }
        
        do {
        let persons: PersonRootDecodableType1 = try decoder.decode(PersonRootDecodableType1.self, from: data)
            return persons.data
        }
        catch {
            return self.next?.decodeDataToPersons(from: data)
        }
    }
}

class DataToPersonHander2: ResponsePersonsHandler {
    var next: ResponsePersonsHandler?
    func decodeDataToPersons(from data: Data) -> [Person]? {
        let decoder = JSONDecoder()
        
        struct PersonRootDecodableType2: Codable {
            let result: [Person]
        }
        
        do {
        let persons: PersonRootDecodableType2 = try decoder.decode(PersonRootDecodableType2.self, from: data)
            return persons.result
        }
        catch {
            return self.next?.decodeDataToPersons(from: data)
        }
    }
}

class DataToPersonHander3: ResponsePersonsHandler {
    var next: ResponsePersonsHandler?
    func decodeDataToPersons(from data: Data) -> [Person]? {
        let decoder = JSONDecoder()
        do {
        let persons: [Person] = try decoder.decode([Person].self, from: data)
            return persons
        }
        catch {
            return self.next?.decodeDataToPersons(from: data)
        }
    }
}

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}


let dataToPersonHander1 = DataToPersonHander1()
let dataToPersonHander2 = DataToPersonHander2()
let dataToPersonHander3 = DataToPersonHander3()

dataToPersonHander1.next = dataToPersonHander2
dataToPersonHander2.next = dataToPersonHander3

let responsePersonsHandler: ResponsePersonsHandler = dataToPersonHander1


let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

responsePersonsHandler.decodeDataToPersons(from: data1)
responsePersonsHandler.decodeDataToPersons(from: data2)
responsePersonsHandler.decodeDataToPersons(from: data3)
