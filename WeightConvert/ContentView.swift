//
//  ContentView.swift
//  WeightConvert
//
//  Created by Mykola Chaikovskyi on 23.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var originalWeight = 0.0
    @State private var selectedOgUnit = "g"
    @State private var selectedConvertedUnit = "kg"
    
    @FocusState private var isOgUnitFocused: Bool
    
    let units = ["g", "kg", "t", "lbs", "oz"]
    
    var convertedWeight: Double {
        let weightInKilograms: Double
    
        switch selectedOgUnit {
        case "g":
            weightInKilograms = originalWeight / 1000
        case "kg":
            weightInKilograms = originalWeight
        case "t":
            weightInKilograms = originalWeight * 1000
        case "lbs":
            weightInKilograms = originalWeight / 2.2
        case "oz":
            weightInKilograms = originalWeight / 35.273962
        default:
            weightInKilograms = 0
        }
        
        switch selectedConvertedUnit {
        case "g":
            return weightInKilograms * 1000
        case "kg":
            return weightInKilograms
        case "t":
            return weightInKilograms / 1000
        case "lbs":
            return weightInKilograms * 2.2
        case "oz":
            return weightInKilograms * 35.273962
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Original") {
                    Picker("Select your original unit", selection: $selectedOgUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Weight", value: $originalWeight, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isOgUnitFocused)
                }
                Section("Converted") {
                    Picker("Select unit to convert to", selection: $selectedConvertedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(convertedWeight.formatted()) \(selectedConvertedUnit)")
                }
            }
            .navigationTitle("WeightConvert")
            .toolbar {
                if isOgUnitFocused {
                    Button("Done") {
                        isOgUnitFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
