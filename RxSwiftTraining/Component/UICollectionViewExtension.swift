//
//  UICollectionViewExtension.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/29.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Cannot create new cell") }
        return cell
    }

    public func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView, T: ReusableView {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    #warning("TODO : この拡張全然対応できてない💩💩💩💩💩💩💩💩💩💩💩💩💩")
    public func compositionalLayout(itemWidthDimension: NSCollectionLayoutDimension,
                                    itemHeightDimension: NSCollectionLayoutDimension,
                                    groupWidthDimension: NSCollectionLayoutDimension? = nil,
                                    groupHeightDimension: NSCollectionLayoutDimension? = nil,
                                    interItemSpacing: NSCollectionLayoutSpacing? = nil) {
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidthDimension,
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        var groupWidth = itemWidthDimension
        var groupHeight = itemHeightDimension
        if groupWidthDimension != nil { groupWidth = groupWidthDimension! }
        if groupHeightDimension != nil { groupHeight = groupHeightDimension! }
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        group.interItemSpacing = interItemSpacing

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionViewLayout = layout
    }
}
