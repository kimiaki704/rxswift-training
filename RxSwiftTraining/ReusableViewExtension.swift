//
//  ReusableViewExtension.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/29.
//  Copyright © 2020 kimioman. All rights reserved.
//

extension ReusableView {
    public static var reuseIdentifier: String {
        "reuse-" + String(describing: self)
    }
}
