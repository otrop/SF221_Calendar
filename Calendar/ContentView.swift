//
//  ContentView.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddTask = false
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Home()
            AddButton()
                .padding()
                .foregroundColor(.white)
                .onTapGesture {
                    showAddTask.toggle()
                    }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .sheet(isPresented: $showAddTask){
                MakeTask()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


