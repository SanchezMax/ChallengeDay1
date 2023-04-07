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
    @State private var convertFrom = 0.0
    @State private var inputUnitTemp: Temperature = .celsius
    @State private var outputUnitTemp: Temperature = .celsius
    
    private var convertTo: Double {
        switch inputUnitTemp {
        case .celsius:
            switch outputUnitTemp {
            case .celsius:
                return convertFrom
            case .fahrenheit:
                return (convertFrom * 9 / 5) + 32
            case .kelvin:
                return convertFrom + 273.15
            }
        case .fahrenheit:
            switch outputUnitTemp {
            case .celsius:
                return (convertFrom - 32) * 5 / 9
            case .fahrenheit:
                return convertFrom
            case .kelvin:
                return (convertFrom + 273.15 - 32) * 5 / 9
            }
        case .kelvin:
            switch outputUnitTemp {
            case .celsius:
                return convertFrom - 273.15
            case .fahrenheit:
                return ((convertFrom - 273.15) * 9 / 5) + 32
            case .kelvin:
                return convertFrom
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Enter temperature to convert:") {
                    HStack {
                        TextField("0.0", value: $convertFrom, format: .number)
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
                        Text(convertTo, format: .number)
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
