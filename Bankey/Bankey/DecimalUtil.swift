//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Simran Preet Singh Narang on 2023-10-29.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
