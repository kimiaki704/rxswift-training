//
//  TodoListViewController.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/14.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TodoListViewController: UIViewController, Instantiatable {
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView!

    private var todos = BehaviorRelay<[Todo]>(value: [])
    private var filteredTodos: [Todo] = []
    private let disposeBag = DisposeBag()

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

    @objc private func rightNavItemButtonTapped(_ sender: UIButton) {
        let vc = AddTodoViewController.instantiate()

        vc.todoSubjectObservable
            .subscribe(onNext: { [weak self] todo in
                guard let self = self else { return }
                self.todos.accept(self.todos.value + [todo])
                let priority = Todo.Priority(rawValue: self.segmentedControl.selectedSegmentIndex - 1)
                self.filterTodos(type: priority)
            }).disposed(by: disposeBag)

        navigationController?.pushViewController(vc, animated: true)
    }

    private func filterTodos(type: Todo.Priority?) {
        if let type = type {
            todos.map { todos in
                todos.filter { $0.type == type }
            }
            .subscribe(onNext: { [weak self] todos in
                guard let self = self else { return }
                self.filteredTodos = todos
                self.reloadCollectionView()
            }).disposed(by: disposeBag)
        } else {
            filteredTodos = todos.value
            reloadCollectionView()
        }
    }

    @IBAction func priorityChanged(_ sender: UISegmentedControl) {
        let priority = Todo.Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTodos(type: priority)
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension TodoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredTodos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TodoListViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TodoListViewCell
        cell.setup(filteredTodos[indexPath.row].title)
        return cell
    }
}
