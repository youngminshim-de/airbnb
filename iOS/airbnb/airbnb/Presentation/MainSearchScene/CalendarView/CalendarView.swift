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
        //setUpCalenderView()
    }
    
    // 스토리보드로
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCalenderView()
    }
    
    func setUpCalenderView() {
        self.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        self.allowsMultipleSelection = true
        self.scrollDirection = .vertical
        
        self.appearance.headerTitleColor = .black
        self.appearance.headerTitleFont = .boldSystemFont(ofSize: 17)
        self.appearance.headerSeparatorColor = .none
        self.appearance.headerDateFormat = "M월 YYYY"
        self.appearance.headerTitleAlignment = .left
        
        self.appearance.weekdayTextColor = .systemGray
        self.appearance.selectionColor = .black
        self.today = nil
        self.placeholderType = .none
        self.locale = Locale(identifier: "ko_KR")
    }
}

class CalendarViewDelegate: NSObject, FSCalendarDelegate, FSCalendarDelegateAppearance {
    // 뷰모델을 가지고 있고, 그 뷰모델을 업데이트 해줘야한다.
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        performDateSelect(calendar, date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //updateCheckIn(calendar)
        performDateSelect(calendar, date: date)
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        configureCell(calendar, cell: cell, for: date, at: monthPosition)
    }
    
    private func performDateSelect(_ calender: FSCalendar, date: Date) {
        
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            print(calender.selectedDates)
            configureVisibleCells(calender)
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calender.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                configureVisibleCells(calender)
                return
            }
            
            let range = dateRange(from: firstDate!, to: date)
            
            lastDate = range.last
            
            for d in range {
                calender.select(d)
            }
            
            datesRange = range
            
            configureVisibleCells(calender)
            return
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calender.selectedDates {
                calender.deselect(d)
            }
            
            firstDate = date
            lastDate = nil
            datesRange = [firstDate!]
            calender.select(firstDate)
            configureVisibleCells(calender)
            return
        }
        configureVisibleCells(calender)
    }
    
    private func dateRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        
        var dateArray = [Date]()
        var tempDate = from
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate) ?? Date()
            dateArray.append(tempDate)
        }
        return dateArray
    }
    
    private func configureVisibleCells(_ calendar: FSCalendar) {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            configureCell(calendar, cell: cell, for: date!, at: position)
        }
    }
    
    private func configureCell(_ calendar: FSCalendar, cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let diyCell = (cell as! DIYCalendarCell)
        // Custom today circle
        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {
            
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        diyCell.selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        diyCell.selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        diyCell.selectionType = .leftBorder
                    }
                    else {
                        diyCell.selectionType = .single
                    }
                }
            }
            else {
                diyCell.selectionType = .none
            }
            
        } else {
            diyCell.selectionType = .none
        }
    }
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
    
    func formatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter.string(from: date)
    }
}

class CalendarViewDataSource: NSObject, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
}
