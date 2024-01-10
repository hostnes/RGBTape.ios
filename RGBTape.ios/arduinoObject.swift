import SwiftUI
import Combine

class arduinoObject: ObservableObject, Codable {
    @Published var name: String
    @Published var ipAddress: String
    @Published var red: Bool
    @Published var redPin: String
    @Published var green: Bool
    @Published var greenPin: String
    @Published var blue: Bool
    @Published var bluePin: String
    @Published var brightness: Float
    
    enum CodingKeys: CodingKey {
        case name, ipAddress, red, redPin, green, greenPin, blue, bluePin, brightness
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        ipAddress = try container.decode(String.self, forKey: .ipAddress)
        red = try container.decode(Bool.self, forKey: .red)
        redPin = try container.decode(String.self, forKey: .redPin)
        green = try container.decode(Bool.self, forKey: .green)
        greenPin = try container.decode(String.self, forKey: .greenPin)
        blue = try container.decode(Bool.self, forKey: .blue)
        bluePin = try container.decode(String.self, forKey: .bluePin)
        brightness = try container.decode(Float.self, forKey: .brightness)
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(ipAddress, forKey: .ipAddress)
        try container.encode(red, forKey: .red)
        try container.encode(redPin, forKey: .redPin)
        try container.encode(green, forKey: .green)
        try container.encode(greenPin, forKey: .greenPin)
        try container.encode(blue, forKey: .blue)
        try container.encode(bluePin, forKey: .bluePin)
        try container.encode(brightness, forKey: .brightness)
    }

    init(name: String,
         ipAddress: String,
         red: Bool = false,
         redPin: String,
         green: Bool = false,
         greenPin: String,
         blue: Bool = false,
         bluePin: String,
         brightness: Float = 0
    ) {
        self.name = name
        self.ipAddress = ipAddress
        self.red = red
        self.redPin = redPin
        self.green = green
        self.greenPin = greenPin
        self.blue = blue
        self.bluePin = bluePin
        self.brightness = brightness
    }
}

extension arduinoObject: Equatable {
    static func == (lhs: arduinoObject, rhs: arduinoObject) -> Bool {
        return lhs.name == rhs.name &&
               lhs.ipAddress == rhs.ipAddress &&
               lhs.red == rhs.red &&
               lhs.redPin == rhs.redPin &&
               lhs.green == rhs.green &&
               lhs.greenPin == rhs.greenPin &&
               lhs.blue == rhs.blue &&
               lhs.bluePin == rhs.bluePin &&
               lhs.brightness == rhs.brightness
    }
}
