import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = ArduinoObjectsViewModel()

    @State private var selectedObjects: [arduinoObject] = [
        arduinoObject(
            name: "Test",
            ipAddress: "127.0.0.1",
            red: true,
            redPin: "13",
            green: false,
            greenPin: "14",
            blue: true,
            bluePin: "17")
    ]
    @State var arduinoObjectsDefaults: [arduinoObject] = {
        let key = "arduinoObjectsKey"
        
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let loadedObjects = try? JSONDecoder().decode([arduinoObject].self, from: savedData) {
                return loadedObjects
            }
        }
        return []
    }()
    var body: some View {
        NavigationView {
            Form {
                ForEach(viewModel.arduinoObjectsDefaults.indices, id: \.self) { index in
                    NavigationLink(
                        destination: DetailView(viewModel: viewModel, object: viewModel.arduinoObjectsDefaults[index]),
                        label: {
                            Text(viewModel.arduinoObjectsDefaults[index].name)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(10)
                                .buttonStyle(.borderedProminent)
                        }
                    )
                }
            }
            .navigationTitle("Title")
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: addObjectView(viewModel: viewModel),
                    label: {
                        Text("Add")
                            .padding()
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 20))
                    }
                )
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

