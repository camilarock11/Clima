//
//  WeatherData.swift
//  ClimaAgora
//
//  Created by Camila Roque on 04/09/23.
//

import Foundation

struct WeatherData: Codable {
    struct Current: Codable {
        let tempC: Double
        let humidity: Int
        // Adicione outras propriedades que você deseja exibir, como a descrição do tempo.
    }

    let current: Current
}
