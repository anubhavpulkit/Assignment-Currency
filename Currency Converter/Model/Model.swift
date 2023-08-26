//
//  Model.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 25/08/23.
//

import Foundation

struct ExchangeRateModel: Decodable{
    let base_code: String
    let target_code: String
    let conversion_rate: Float
    let conversion_result: Float
}
