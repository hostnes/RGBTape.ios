import SwiftUI
import Combine

class ArduinoObjectsViewModel: ObservableObject {
    @Published var arduinoObjectsDefaults: [arduinoObject] = []

    init() {
        loadArduinoObjects()
    }

    func loadArduinoObjects() {
        let key = "arduinoObjectsKey"

        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let loadedObjects = try? JSONDecoder().decode([arduinoObject].self, from: savedData) {
                arduinoObjectsDefaults = loadedObjects
            }
        }
    }

    func saveArduinoObjects() {
        if let encodedData = try? JSONEncoder().encode(arduinoObjectsDefaults) {
            UserDefaults.standard.set(encodedData, forKey: "arduinoObjectsKey")
        }
    }
    
    func deleteObject(_ object: arduinoObject) {
        if let index = arduinoObjectsDefaults.firstIndex(of: object) {
            arduinoObjectsDefaults.remove(at: index)
            saveArduinoObjects()

        }
    }
}
