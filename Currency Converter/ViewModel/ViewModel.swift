//
//  ViewModel.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 25/08/23.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var conversion: ExchangeRate? = nil
    
    @Published var historyBaseCode: [String] = []
    @Published var historyTargetCount: [String] = []
    @Published var historyAmount: [String] = []
    @Published var historyConvertedAmount: [Float] = []
    @Published var histroyConversionRate:[Float] = []
    @Published var timin: [String] = []
    
    func fetchData(baseCode: String, targetCode: String, amount: String) {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/7cff21eee63121b9b48a03f4/pair/\(baseCode)/\(targetCode)/\(amount)") else { return }
        URLSession.shared.dataTask(with: url) { data, result, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    DispatchQueue.main.async { [self] in
                        self.conversion = decodedData
                        self.historyBaseCode.append(conversion?.base_code ?? "")
                        self.historyTargetCount.append(conversion?.target_code ?? "")
                        self.historyAmount.append(amount)
                        self.historyConvertedAmount.append(conversion?.conversion_result ?? 0.0)
                        self.histroyConversionRate.append(conversion?.conversion_rate ?? 0.0)
                        
                        UserDefaultManager.standard.setBaseCodeHistory(keywordsArray: historyBaseCode)
                        
//                        print(self.historyBaseCode, "historyBaseCode")
//                        print(self.historyTargetCount, "historyTargetCount")
//                        print(self.historyAmount, "historyAmount")
//                        print(self.historyConvertedAmount, "historyConvertedAmount")
//                        print(self.histroyConversionRate, "self.histroyConversionRate")
                    }
                } catch {
                    //Print JSON decoding error
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            } else if let error = error {
                //Print API call error
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
