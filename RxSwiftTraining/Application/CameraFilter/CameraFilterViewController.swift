//
//  CameraFilterViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/30.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

final class CameraFilterViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        title = "CameraFilter"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navButton = UIButton()
        navButton.setImage(UIImage(systemName: "plus"), for: .normal)
        navButton.sizeToFit()
        navButton.tintColor = .systemBlue
        navButton.addTarget(self, action: #selector(rightNavItemButtonTapped(_:)), for: .touchUpInside)

        let rightNavItem = UIBarButtonItem(customView: navButton)
        navigationItem.rightBarButtonItem = rightNavItem
    }

    @objc private func rightNavItemButtonTapped(_ sender: UIButton) {
        let vc = SelectImageViewController.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: FilterButtonAction

extension CameraFilterViewController {
    @IBAction private func filterButtonTapped(_ sender: UIButton) {}
}
