//
//  ContentView.swift
//  ClimaAgora
//
//  Created by Camila Roque on 04/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherData?
    @State private var isLoading = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Carregando...")
            } else if let weatherData = weatherData {
                Text("Temperatura: \(weatherData.current.tempC)°C")
                Text("Umidade: \(weatherData.current.humidity)%")
            } else {
                Text("Não foi possível obter os dados meteorológicos.")
            }
        }
        .onAppear {
            fetchWeatherData()
        }
    }

    func fetchWeatherData() {
        isLoading = true
        let urlString = "Insira a URL do servico que utilizara aqui"

        let apiUrl = URL(string: urlString)!

        URLSession.shared.dataTask(with: apiUrl) { data, _, error in
            if let error = error {
                print("Erro ao buscar dados: \(error)")
                isLoading = false
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        weatherData = decodedData
                        isLoading = false
                    }
                } catch {
                    print("Erro ao decodificar dados: \(error)")
                    isLoading = false
                }
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
