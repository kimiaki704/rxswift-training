//
//  ViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/29.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Titles: String, CaseIterable {
        case helloRxSwift

        func to() -> UIViewController {
            switch self {
            case .helloRxSwift:
                return HelloRxSwiftViewController.instantiate()
            }
        }
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self)
        collectionView.compositionalLayout(itemWidthDimension: .fractionalWidth(1.0),
                                           itemHeightDimension: .absolute(75))
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Titles.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(Titles.allCases[indexPath.row].rawValue)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("💩 App : \(Titles.allCases[indexPath.row].rawValue) \n")
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = Titles.allCases[indexPath.row].to()
        navigationController?.pushViewController(vc, animated: true)
    }
}