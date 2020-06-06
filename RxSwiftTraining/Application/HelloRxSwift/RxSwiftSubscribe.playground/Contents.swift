
import UIKit
import RxSwift

let observable = Observable.just(1)

let observable2 = Observable.of(1, 2, 3)

let observable3 = Observable.of([1, 2, 3])

let observable4 = Observable.from([1, 2, 3, 4, 5])

observable.subscribe { event in
    print("💩 event : \(event) \n")
}

observable2.subscribe { event in
    print("💩 event2 : \(event) \n")
}

observable3.subscribe { event in
    print("💩 event3 : \(event) \n")
}

observable4.subscribe { event in
    print("💩 event4 : \(event) \n")
}

#warning("TODO : of(1, 2, 3) と from([1, 2, 3])一緒じゃ？？")
print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")


observable.subscribe(onNext: { element in
    print("💩 element : \(element) \n")
})

observable2.subscribe(onNext: { element in
    print("💩 element2 : \(element) \n")
})

observable3.subscribe(onNext: { element in
    print("💩 element3 : \(element) \n")
})

observable4.subscribe(onNext: { element in
    print("💩 element4 : \(element) \n")
})


print("🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠🦠")


let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
        print("💩 element : \($0) \n")
    }
    .disposed(by: disposeBag)

let testes = Observable<String>.create  { observer in
    print("💩 oppai : \(observer) \n")
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
    }
    .subscribe(onNext: { print("💩 next : \($0) \n") },
               onError: { print("💩 erroe : \($0) \n") },
               onCompleted: { print("💩 complete \n") },
               onDisposed: { print("💩 disposed \n") } )
    .disposed(by: disposeBag)


print("💩 unko : \(testes) \n")
