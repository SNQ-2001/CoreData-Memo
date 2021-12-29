//
//  ViewModel.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject{
    @Published var index: Int = 0
    @Published var title: String = ""
    @Published var text: String = ""
    @Published var isNewMemo = false
    @Published var Item: Memo!

    
    //編集確定 or 新規作成
    func CreateMemo(context : NSManagedObjectContext) {
        if Item != nil{
            Item.index = UnixTime()
            Item.title = title
            Item.text = text
            try! context.save()

            Item = nil
            isNewMemo.toggle()
            index = UnixTime()
            title = ""
            text = ""
            return
        }
        let newMemo = Memo(context: context)
        newMemo.index = UnixTime()
        newMemo.title = title
        newMemo.text = text
        do{
            try context.save()
            isNewMemo.toggle()
            index = UnixTime()
            title = ""
            text = ""
        }
        catch{
            print(error.localizedDescription)
        }
    }

    //編集時
    func EditMemo(item: Memo) {
        Item = item
        index = item.index
        title = item.title
        text = item.text
        isNewMemo.toggle()
    }
    
    //IDの重複を避ける為,UnixTimeをIDに適用
    func UnixTime() -> Int {
        let dt = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
        let date: Date? = dateFormatter.date(from: dateFormatter.string(from: dt))
        let dateUnix: TimeInterval? = date?.timeIntervalSince1970

        return Int(dateUnix!)
    }
}
