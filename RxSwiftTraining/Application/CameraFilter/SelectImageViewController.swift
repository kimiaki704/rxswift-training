//
//  SelectImageViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/30.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

final class SelectImageViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var collectionView: UICollectionView!

    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }

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
        print("💩 App \(indexPath) \n")

        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedAsset = images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: CGSize(width: 300, height: 300),
                                              contentMode: .aspectFit,
                                              options: nil) { [weak self] image, info in
                                                guard let self = self, let image = image, let info = info else { return }
                                                guard let isDegradedImage = info["PHImageResultIsDegradedKey"] as? Bool else { return }

                                                if !isDegradedImage {
                                                    self.selectedPhotoSubject.onNext(image)
                                                    self.navigationController?.popViewController(animated: true)
                                                }
        }
    }
}
