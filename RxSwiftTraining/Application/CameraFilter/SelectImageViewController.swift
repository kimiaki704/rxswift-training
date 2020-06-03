//
//  SelectImageViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/30.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import Photos

final class SelectImageViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var images: [PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupCollectionView()
        getPhotos()
    }
    
    private func setup() {
        title = "SelectImage"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectImageViewCell.self)
        let cellCount = Int(view.bounds.width / 100)
        let cellWidthSum = cellCount * 100
        let spacing = view.bounds.width - CGFloat(cellWidthSum) / CGFloat(cellCount - 2)
        collectionView.compositionalLayout(itemWidthDimension: .absolute(100),
                                           itemHeightDimension: .absolute(100),
                                           groupWidthDimension: .fractionalWidth(1.0),
                                           interItemSpacing: .fixed(spacing/2))
    }
    
    private func getPhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { object, count, stop in
                    self.images.append(object)
                }
                self.images.reverse()
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        }
    }
}

extension SelectImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelectImageViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(images[indexPath.row])
        return cell
    }
}

extension SelectImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
