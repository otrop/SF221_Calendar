 //
//  Home.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI
import EventKit
import EventKitUI

struct Home: View {
    
    @State var CurrentDate : Date = Date()

    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                CustomDatePicker(CurrentDate: $CurrentDate)
            }
            .padding(.vertical)
        }
        //safe area view
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
