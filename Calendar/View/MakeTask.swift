//
//  MakeTask.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI
import EventKit
import EventKitUI

struct MakeTask: View {
    @State private var taskTitle: String = ""
    @State private var description: String = ""
    @State private var taskDate = Date()
    
    var body: some View {
        VStack {
            Text("Add your new task")
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Form{
            TextField(
                    "Title",
                    text: $taskTitle
            )
            .padding(10.0)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1))
                .disableAutocorrection(true)
            
            TextField(
                    "Description",
                    text: $description
                )
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1))
                .disableAutocorrection(true)
                DatePicker("Date", selection: $taskDate)
            }
            .cornerRadius(10)
            Button{
              var newTask =  TaskDetail(title: taskTitle ,time: taskDate)
                
                } label: {Text("Save").font(.headline).bold()}
            .foregroundColor(.white)
            .padding(.all, 10.0)
            .background(
                Color.blue
                    .opacity(1)
                    .cornerRadius(10))
        }
        .padding(.vertical,10)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        }
}

struct MakeTask_Previews: PreviewProvider {
    static var previews: some View {
        MakeTask()
    }
}
