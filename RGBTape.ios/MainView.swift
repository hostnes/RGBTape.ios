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
    var body: some View {
        NavigationView {
            Form {
                if viewModel.arduinoObjectsDefaults.count != 0 {
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
                else {
                    HStack {
                        Spacer()
                        Text("Empty List").font(.system(size: 20))
                        Spacer()
                    }
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

