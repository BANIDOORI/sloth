//
//  Lesson.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import Foundation

struct Lesson: Codable, Hashable {
    let categoryName: String?
    let currentProgressRate: Int?
    let endDate: String?
    let goalProgressRate: Int?
    let isFinished: Bool?
    let lessonID: Int?
    let lessonName: String?
    let lessonStatus: String?
    let price: Int?
    let remainDay: Int?
    let presentNumber: Int?
    let siteName: String?
    let startDate: String?
    let totalNumber: Int?
    let untilTodayFinished: Bool?
    let untilTodayNumber: Int?

    enum CodingKeys: String, CodingKey {
        case lessonID = "lessonId"
        case lessonName, lessonStatus, price, remainDay,
             siteName, startDate, totalNumber, categoryName,
             currentProgressRate, endDate, goalProgressRate, isFinished,
             untilTodayFinished, untilTodayNumber, presentNumber
    }
}

typealias Lessons = [Lesson]
