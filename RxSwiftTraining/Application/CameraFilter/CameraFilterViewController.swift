//
//  CameraFilterViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/30.
//  Copyright © 2020 kimioman. All rights reserved.
//

import RxSwift
import UIKit

final class CameraFilterViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var filterButton: UIButton!

    private let disposeBag = DisposeBag()

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

        filterButton.isHidden = true
    }

    @objc private func rightNavItemButtonTapped(_ sender: UIButton) {
        let vc = SelectImageViewController.instantiate()

        vc.selectedPhoto.subscribe(onNext: { [weak self] photo in
            guard let self = self else { return }
            self.update(with: photo)
        }).disposed(by: disposeBag)
        
        navigationController?.pushViewController(vc, animated: true)
    }

    private func update(with photo: UIImage) {
        imageView.image = photo
        filterButton.isHidden = false
    }
}

// MARK: FilterButtonAction

extension CameraFilterViewController {
    @IBAction private func filterButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        image.applyFilter()
            .subscribe(onNext: { filteredImage in
                self.imageView.image = filteredImage
            })
            .disposed(by: disposeBag)
    }
}
