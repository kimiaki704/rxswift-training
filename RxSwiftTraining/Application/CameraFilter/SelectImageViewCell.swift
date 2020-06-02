//
//  SelectImageViewCell.swift
//  RxSwiftTraining
//
//  Created by Suzuki Kimiaki on 2020/06/03.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

class SelectImageViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet private var imageView: UIImageView!

    public func setup(_ image: UIImage) {
        contentView.isUserInteractionEnabled = false
        imageView.image = image
    }
}
