import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let publishSubject = PublishSubject<String>()

publishSubject.onNext("Issue 1")

publishSubject.subscribe { event in
    print("💩 event : \(event) \n")
}

publishSubject.onNext("Issue 2")
publishSubject.onNext("Issue 3")


//subject.dispose()

publishSubject.onCompleted()

publishSubject.onNext("Issue 4")

#warning("TODO : PublishSubject -> subscribe前イベントはキャッシュしない")

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

let behaviorSubject = BehaviorSubject(value: "Initial Value")

behaviorSubject.onNext("Last Issue")
behaviorSubject.onNext("Last Issue2")

behaviorSubject.subscribe { event in
    print("💩 event : \(event) \n")
}

behaviorSubject.onNext("Issue 1")

#warning("TODO : BehaviorSubject -> subscribe直前イベントを1つだけキャッシュ")

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")

replaySubject.subscribe {
    print("💩 replay : \($0) \n")
}

replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")

print("🦠🦠🦠🦠🦠🦠replay 2🦠🦠🦠🦠🦠🦠🦠🦠")

replaySubject.subscribe {
    print("💩 replay2 : \($0) \n")
}

#warning("TODO : ReplaySubject -> 指定数直前イベントをキャッシュしてる")

print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")

let behaviorRelay = BehaviorRelay(value: "Initial Value")


behaviorRelay.accept("Item 1")

behaviorRelay.asObservable()
    .subscribe {
        print("💩 behaviorRelay : \($0) \n")
    }

