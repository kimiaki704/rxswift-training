//
//  TodoListViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/14.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

final class TodoListViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "TodoList"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navButton = UIButton()
        navButton.setImage(UIImage(systemName: "plus"), for: .normal)
        navButton.sizeToFit()
        navButton.tintColor = .systemBlue
        navButton.addTarget(self, action: #selector(rightNavItemButtonTapped(_:)), for: .touchUpInside)

        let rightNavItem = UIBarButtonItem(customView: navButton)
        navigationItem.rightBarButtonItem = rightNavItem

        collectionView.dataSource = self
        collectionView.register(TodoListViewCell.self)
        collectionView.compositionalLayout(itemWidthDimension: .fractionalWidth(1.0),
                                           itemHeightDimension: .absolute(50))
    }

    @objc private func rightNavItemButtonTapped(_ sender: UIButton) {}
}

extension TodoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TodoListViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TodoListViewCell
        return cell
    }


}
