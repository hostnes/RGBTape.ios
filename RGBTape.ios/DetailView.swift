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
            Form {
                HStack {
                    Text("IPAddress")
                        .foregroundColor(.gray)
                    TextField("Red Pin", text: $ipAddress)
                        .padding()
                }
                HStack {
                    Text("RedPin     ")
                        .foregroundColor(.gray)
                    TextField("Red Pin", text: $redPin)
                        .padding()
                }
                HStack {
                    Text("GreenPin  ")
                        .foregroundColor(.gray)
                    TextField("Green Pin", text: $greenPin)
                        .padding()
                }
                HStack {
                    Text("BuePin      ")
                        .foregroundColor(.gray)
                    TextField("Green Pin", text: $bluePin)
                        .padding()
                }
                    Toggle(isOn: $redToggle) {
                        Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.red)
                    }.padding(.vertical, 10).padding(.horizontal, 20)
                    Toggle(isOn: $greenToggle) {
                        Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.green)
                    }.padding(.vertical, 10).padding(.horizontal, 20)
                    Toggle(isOn: $blueToggle) {
                        Rectangle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50).foregroundColor(Color.blue)
                    }.padding(.vertical, 10).padding(.horizontal, 20)
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

