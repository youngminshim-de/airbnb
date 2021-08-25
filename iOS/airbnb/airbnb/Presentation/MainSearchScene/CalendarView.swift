//
//  CalendarView.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/24.
//

import UIKit
import FSCalendar

class CalendarView: FSCalendar {
    
    // 코드로
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpCalenderView()
    }
    
    // 스토리보드로
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCalenderView()
    }
    
    func setUpCalenderView() {
        self.allowsMultipleSelection = true
        self.scrollDirection = .vertical
        
        self.appearance.titleDefaultColor = .black
        self.appearance.headerTitleColor = .systemGray
        self.appearance.headerDateFormat = "M월 YYYY"
        self.locale = Locale(identifier: "ko_KR")
    }
}

extension CalendarView: FSCalendarDelegate {
//    private var conditionData: FindingAccommdationCondition!
//
//    init(conditionData: FindingAccommdationCondition) {
//        self.conditionData = conditionData
//    }
//
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        performDateSelect(calendar, date: date)
//        updateCheckIn(calendar)
//    }
//
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        calendar.select(date)
//        updateCheckIn(calendar)
//    }
//
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        performDateDeselect(calendar, date: date)
//        return true
//    }
//
//    private func performDateDeselect(_ calender: FSCalendar, date: Date) {
//        calender.selectedDates.forEach({
//            calender.deselect($0)
//        })
//    }
//
//    private func performDateSelect(_ calender: FSCalendar, date: Date) {
//        let sorted = calender.selectedDates.sorted { $0 < $1 }
//        if sorted.count > 1 && date == sorted.first {
//            performDateDeselect(calender, date: date)
//            calender.select(date)
//            return
//        }
//        if let firstData = sorted.first,
//           let lastData = sorted.last {
//            let ranges = dateRange(from: firstData, to: lastData)
//            ranges.forEach {
//                calender.select($0)
//            }
//        }
//    }
//
//    func dateRange(from: Date, to: Date) -> [Date] {
//        if from > to { return [Date]() }
//
//        var dateArray = [Date]()
//        var tempDate = from
//
//        while tempDate < to {
//            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate) ?? Date()
//            dateArray.append(tempDate)
//        }
//        return dateArray
//    }
//
//    func updateCheckIn(_ calender: FSCalendar) {
//        let sorted = calender.selectedDates.sorted { $0 < $1 }
//        if sorted.count == 1 {
//            conditionData.update(firstDate: formatter(date: sorted.first ?? Date()))
//            conditionData.update(secondDate: "")
//        } else {
//            conditionData.update(firstDate: formatter(date: sorted.first ?? Date()))
//            conditionData.update(secondDate: formatter(date: sorted.last ?? Date()))
//        }
//    }
//
//    func formatter(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM월 dd일"
//        return formatter.string(from: date)
//    }
}
