import UIKit
import RxSwift
import PlaygroundSupport

let ignore = PublishSubject<String>()
let elementAt = PublishSubject<String>()
let disposeBag = DisposeBag()

ignore
    .ignoreElements()
    .subscribe { _ in
        print("Subscription is called")
}.disposed(by: disposeBag)

ignore.onNext("A")
ignore.onNext("B")
ignore.onNext("C")
ignore.onCompleted()

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")
#warning("指定数目のイベントまで何もしない")
elementAt.elementAt(2)
    .subscribe(onNext: { _ in
        print("You are out")
    }).disposed(by: disposeBag)

elementAt.onNext("A")
elementAt.onNext("B")
elementAt.onNext("C")

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("文字通りのfilter")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .filter { $0 % 2 == 0}
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")
#warning("指定数スキップする")
Observable.of("A", "B", "C", "D", "E", "F", "G", "H")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("指定の条件を満たすまでスキップする")
Observable.of(2, 2, 2, 3, 4, 4, 4, 10)
    .skipWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("指定したObservableがonNextを発行するまで、元のObservableが発行したイベントを無視")

let skipUntil = PublishSubject<String>()
let trigger = PublishSubject<String>()

skipUntil.skipUntil(trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
skipUntil.onNext("A")
skipUntil.onNext("B")
skipUntil.onNext("C")

trigger.onNext("AAA")
skipUntil.onNext("okkkkkkkkk")

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("指定した回数だけ実行する")
Observable.of(1, 2, 3, 4, 5, 6)
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("指定の条件を満たしたら終了する")
Observable.of(2, 2, 2, 4, 6, 8, 9, 10, 12)
    .takeWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

#warning("指定したObservableがonNextを発行したら終了する")

let takeUntil = PublishSubject<String>()
let takeTrigger = PublishSubject<String>()

takeUntil.takeUntil(takeTrigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
takeUntil.onNext("A")
takeUntil.onNext("B")
takeUntil.onNext("C")

takeTrigger.onNext("AAA")
takeUntil.onNext("okkkkkkkkk")
