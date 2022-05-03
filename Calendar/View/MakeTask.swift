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
class ViewController: UIViewController, EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    let eventStore = EKEventStore()
    var time = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
                    DispatchQueue.main.async {
                        if (granted) && (error == nil) {
                            let event = EKEvent(eventStore: self.eventStore)
                            event.title = "Keynote Apple"
                            event.startDate = self.time
                            event.url = URL(string: "https://apple.com")
                            event.endDate = self.time
                            let eventController = EKEventEditViewController()
                            eventController.event = event
                            eventController.eventStore = self.eventStore
                            eventController.editViewDelegate = self
                            self.present(eventController, animated: true, completion: nil)
                            
                        }
                    }
                })
    }
    
    
}
