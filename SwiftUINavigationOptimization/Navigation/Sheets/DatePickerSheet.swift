//
//  DatePickerModalView.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 21/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct DatePickerSheet: View {
    enum DateType { case time, date }

    var type: DateType
    var customTitle: String?
    var completion: DateCompletion
    
    @State private var date: Date
    
    init(initial: Date, type: DatePickerSheet.DateType, customTitle: String?, completion: @escaping DateCompletion) {
        self.type = type
        self.customTitle = customTitle
        self.completion = completion
        self._date = State(initialValue: initial)
    }

    
    // MARK: - Views
    
    var body: some View {
        Sheet(title: title, canCancel: false, onSave: { completion(date) }) {
            picker
                .accentColor(.oCyan)
                .colorScheme(.dark)
                .labelsHidden()
                .padding(.bottom, 50)
        }
    }
    
    var title: String {
        if let title = customTitle { return title }
        
        switch type {
        case .time: return "Time"
        case .date: return "Date"
        }
    }
    
    @ViewBuilder
    var picker: some View {
        switch type {
        case .time:
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
            
        case .date:
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
        }
    }
    
    
    // MARK: - Functions

}


struct DatePickerModalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DatePickerSheet(initial: Date(),
                            type: .date,
                            customTitle: nil,
                            completion: { _ in })

            DatePickerSheet(initial: Date(),
                            type: .time,
                            customTitle: nil,
                            completion: { _ in })
        }
    }
}
