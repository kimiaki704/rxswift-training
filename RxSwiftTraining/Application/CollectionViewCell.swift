//
//  CollectionViewCell.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/29.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet private var textLabel: UILabel!

    public func setup(_ text: String) {
        textLabel.text = text
    }
}
