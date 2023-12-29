//
//  ContentView.swift
//  ChallengeDay1
//
//  Created by Aleksey Novikov on 07.04.2023.
//

import SwiftUI

enum Temperature: String, CaseIterable {
    case celsius = "°C"
    case fahrenheit = "°F"
    case kelvin = "°K"
}

struct ContentView: View {
    @State private var inputOrigin = 0.0
    @State private var inputUnitTemp: Temperature = .celsius
    @State private var outputUnitTemp: Temperature = .celsius
    
    private var inputConverted: Double {
        switch inputUnitTemp {
        case .celsius:
            return inputOrigin
        case .fahrenheit:
            return (inputOrigin - 32) * 5 / 9
        case .kelvin:
            return inputOrigin - 273.15
        }
    }
    
    private var output: Double {
        switch outputUnitTemp {
        case .celsius:
            return inputConverted
        case .fahrenheit:
            return (inputConverted * 9 / 5) + 32
        case .kelvin:
            return inputConverted + 273.15
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Enter temperature to convert:") {
                    HStack {
                        TextField("0.0", value: $inputOrigin, format: .number)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $inputUnitTemp) {
                            ForEach(Temperature.allCases, id: \.self) { it in
                                Text(it.rawValue)
                            }
                        }
                    }
                }
                
                Section("Result") {
                    HStack {
                        Text(output, format: .number)
                        Picker("", selection: $outputUnitTemp) {
                            ForEach(Temperature.allCases, id: \.self) { it in
                                Text(it.rawValue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Convert App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
