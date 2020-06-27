//
//  AddTodoViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/14.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import RxSwift

final class AddTodoViewController: UIViewController, Instantiatable {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!

    private let todoSubject = PublishSubject<Todo>()
    var todoSubjectObservable: Observable<Todo> { todoSubject.asObservable() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "AddTodo"
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
        guard let title = textField.text else { return }
        let todo: Todo = .init(title: title, selectedIndex: segmentedControl.selectedSegmentIndex)
        todoSubject.onNext(todo)
        navigationController?.popViewController(animated: true)
    }
}
