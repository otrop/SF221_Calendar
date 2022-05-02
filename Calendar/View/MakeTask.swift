//
//  MakeTask.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI

struct MakeTask: View {
    @State private var title: String = ""
    var body: some View {
        VStack {
            Text("Add your new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(
                    "Title",
                    text: $title
                )
                .disableAutocorrection(true)
            }
        .padding(.vertical,10)
        .padding(.horizontal)
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: .infinity)
        }
}

struct MakeTask_Previews: PreviewProvider {
    static var previews: some View {
        MakeTask()
    }
}
