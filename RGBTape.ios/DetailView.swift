import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ArduinoObjectsViewModel

    @ObservedObject var object: arduinoObject
    @State private var sliderValue: Float = 0
    @State private var ipAddress: String = ""
    @State public var redToggle: Bool = false
    @State public var redPin: String = ""
    @State public var greenToggle: Bool = false
    @State public var greenPin: String = ""
    @State public var blueToggle: Bool = false
    @State public var bluePin: String = ""
    
    @State private var showActionSheet = false

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(object.name)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
            Form {
                List {
                    Section(header: Text("About")) {
                        DisclosureGroup("Application Info") {
                            VStack(alignment: .leading, spacing: 15) {
                                AboutItemView(title: "IPAddress", value: ipAddress)
                                AboutItemView(title: "RedPin", value: redPin)
                                AboutItemView(title: "GreenPin", value: greenPin)
                                AboutItemView(title: "BluePin", value: bluePin)
                            }
                        }
                    }
                }
                Toggle(isOn: $redToggle) {
                    Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.red)
                }.padding(.vertical, 10).padding(.horizontal, 20)
                .onChange(of: redToggle) { _ in
                    object.red = redToggle
                    viewModel.saveArduinoObjects()
                }
                Toggle(isOn: $greenToggle) {
                    Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.green)
                }.padding(.vertical, 10).padding(.horizontal, 20)
                .onChange(of: greenToggle) { _ in
                    object.green = greenToggle
                    viewModel.saveArduinoObjects()
                }
                Toggle(isOn: $blueToggle) {
                    Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.blue)
                }.padding(.vertical, 10).padding(.horizontal, 20)
                .onChange(of: blueToggle) { _ in
                    object.blue = blueToggle
                    viewModel.saveArduinoObjects()
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            showActionSheet = true
                        }, label: {
                            Text("Delete").foregroundColor(.red).padding().font(.system(size: 20))
                        })
                        Spacer()
                    }.actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("Удалить?"),
                            buttons: [
                                .destructive(Text("Delete")) {
                                    viewModel.deleteObject(object)
                                },
                                .cancel(Text("Cancel"))
                            ]
                        )
                    }
                }
            }
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "sun.min.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Slider(value: $sliderValue, in: 0...100)
                    .onChange(of: sliderValue) { _ in
                        object.brightness = sliderValue
                        viewModel.saveArduinoObjects()
                    }
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)

            }.padding()
        }

        .navigationBarTitle("Details")
        .onAppear {
            sliderValue = object.brightness
            ipAddress = object.ipAddress
            redToggle = object.red
            redPin = object.redPin
            greenToggle = object.green
            greenPin = object.greenPin
            blueToggle = object.blue
            bluePin = object.bluePin
        }
    }
}

struct AboutItemView: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
        .padding(.vertical, 5)
    }
}

