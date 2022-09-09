//
//  Todo.swift
//  Kadai-Todo
//
//  Created by Yui Ogawa on 2022/09/09.
//

import Foundation
import RealmSwift

class Todo: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
}
