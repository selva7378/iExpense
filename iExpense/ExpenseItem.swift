//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Remitbee on 12/11/26.
//
import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
