//
//  SheetType.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 21/11/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import Foundation

typealias DateCompletion = (Date) -> ()

protocol SheetType {
    var id: String { get }
}

struct DateSheetType: SheetType {
    var id: String = "DateSheetType"
    var initial: Date
    var type: DatePickerSheet.DateType
    var customTitle: String? = nil
    var completion: DateCompletion
}
