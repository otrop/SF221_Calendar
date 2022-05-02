//
//  CustomDatePicker.swift
//  Calendar
//
//  Created by Chakkrin Matoom on 16/3/2565 BE.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var CurrentDate: Date
    
    //Month update on arrow button clicks
    @State var currentMonth: Int = 0
    var body: some View {
        
        VStack(spacing: 30){
            //Days
            let days: [String] =
                ["SUN","MON","TUE","WED","THU","FRI","SAT"]
            HStack(spacing: 20){
                //Day View
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button{
                    withAnimation{currentMonth -= 1}
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button{
                    withAnimation{currentMonth += 1}
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            HStack(spacing: 0){
                //Date
                ForEach(days,id: \.self){day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                    }
            //Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns,spacing: 15){
                ForEach(extractDate()){ value in
                   CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color.red)
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1: value.date, date2: CurrentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            CurrentDate = value.date
                        }
                }
            }
            VStack(spacing: 15){
                Text("Tasks")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: CurrentDate)
                }){
                    ForEach(task.task){task in
                        VStack(alignment: .leading, spacing: 10){
                            
                            //For each custom timing
                            Text(task.time
                                    .addingTimeInterval(CGFloat
                                    .random(in: 0...5000)),style:
                                    .time)
                                    
                            Text(task.title)
                                .font(.title2.bold())
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color.green
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }
                }
            }
            .padding()
        }
        .onChange(of: currentMonth){ newValue in
            //updating month
            CurrentDate = getCurrentMonth()
        }
    }
    @ViewBuilder
    func CardView(value: DateValue) -> some View{
        VStack{
            if value.day != -1{
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: CurrentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: CurrentDate) ? .white
                              : Color.red)
                        .frame(width: 8, height: 8)
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: CurrentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    
                }
            }
        }
        .padding(.vertical,9)
        .frame(height: 60, alignment: .top)
    }
    
    //checking date
    func isSameDay(date1: Date,date2: Date)-> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //extracing Year And Month for Display
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: CurrentDate)
        
        return date.components(separatedBy: " ")
    }
    func getCurrentMonth() -> Date{
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date() ) else{
            return Date()
        }
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        let calendar = Calendar.current
        //Getting Current Day Month
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap{date -> DateValue
            in
            //getting Date
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        //adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()),at:0)
        }
        return days
    }
}

struct CustomDatePicker_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Extending Dateto get Current Data
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        //getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap{day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
