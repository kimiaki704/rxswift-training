//
//  SelectImageViewCell.swift
//  RxSwiftTraining
//
//  Created by Suzuki Kimiaki on 2020/06/03.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import Photos

class SelectImageViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet private var imageView: UIImageView!

    public func setup(_ asset: PHAsset) {
        contentView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 100, height: 100),
                             contentMode: .aspectFit,
                             options: nil) { [weak self] image, _ in
                                guard let self = self else { return }
                                self.imageView.image = image
        }
    }
}
