import SwiftUI

struct addObjectView: View {
    @ObservedObject var viewModel: ArduinoObjectsViewModel

    @State private var title: String = ""
    @State private var ipAddres: String = ""
    @State private var redPin: String = ""
    @State private var greenPin: String = ""
    @State private var bluePin: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    func saveArduinoObjects(_ objects: [arduinoObject]) {
        if let encodedData = try? JSONEncoder().encode(objects) {
            UserDefaults.standard.set(encodedData, forKey: "arduinoObjectsKey")
        }
    }
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Title:")
                        .foregroundColor(.white)
                    TextField("Title", text: $title)
                        .padding()
                }
                HStack {
                    Text("IP Address:")
                        .foregroundColor(.white)
                    TextField("IP Address", text: $ipAddres)
                        .padding()
                }
                HStack {
                    Text("Red Pin:")
                        .foregroundColor(.white)
                    TextField("Red Pin", text: $redPin)
                        .padding()
                }
                HStack {
                    Text("Green Pin:")
                        .foregroundColor(.white)
                    TextField("Green Pin", text: $greenPin)
                        .padding()
                }
                HStack {
                    Text("Blue Pin:")
                        .foregroundColor(.white)
                    TextField("Blue Pin", text: $bluePin)
                        .padding()
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            let newObject = arduinoObject(
                                name: title,
                                ipAddress: ipAddres,
                                redPin: redPin,
                                greenPin: greenPin,
                                bluePin: bluePin
                            )
                            viewModel.arduinoObjectsDefaults.append(newObject)
                            viewModel.saveArduinoObjects()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Add").foregroundColor(.blue).padding().font(.system(size: 19))
                        })
                        Spacer()
                    }
                }
            }
        }
    }
}
