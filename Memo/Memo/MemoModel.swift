//
//  MemoModel.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import CoreData
import SwiftUI

@objc(Memo)
class Memo: NSManagedObject {
    @NSManaged var index: Int
    @NSManaged var title: String
    @NSManaged var text: String
}

extension Memo: Identifiable {
    var id: Int {
        index
    }
}
