//
//  Date+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

extension Date {
    func format(to format: String = "yyyy.MM.dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
