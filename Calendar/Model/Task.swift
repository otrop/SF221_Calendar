//
//  Task.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI

//Array of task
struct TaskDetail: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}
//Total task meta view
struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [TaskDetail]
    var taskDate: Date
}

//sample
func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasks: [TaskMetaData] = [
    TaskMetaData(task: [
    TaskDetail(title: "Learn Swift"),
    TaskDetail(title: "Learn Java")
    ],taskDate: getSampleDate(offset: 0))
]
