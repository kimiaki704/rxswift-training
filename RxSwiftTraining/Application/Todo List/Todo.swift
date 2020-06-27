//
//  Todo.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/28.
//  Copyright © 2020 kimioman. All rights reserved.
//

import Foundation

struct Todo {
    let title: String
    let type: Priority

    enum Priority: Int {
        case high
        case medium
        case low
    }

    init(title: String, selectedIndex: Int) {
        self.title = title
        self.type = Priority(rawValue: selectedIndex)! // 現時点でcase以外を許容していない
    }
}
