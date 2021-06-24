//
//  Infallible+Bind.swift
//  RxCocoa
//
//  Created by Shai Mishali on 27/08/2020.
//  Copyright © 2020 Krunoslav Zaher. All rights reserved.
//

import RxSwift

public extension InfallibleType {
    /**
     Creates new subscription and sends elements to observer(s).
     In this form, it's equivalent to the `subscribe` method, but it better conveys intent, and enables
     writing more consistent binding code.
     - parameter to: Observers to receives events.
     - returns: Disposable object that can be used to unsubscribe the observers.
     */
    func bind<Observer: ObserverType>(to observers: Observer...) -> Disposable where Observer.Element == Element {
        subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }

    /**
     Creates new subscription and sends elements to observer(s).
     In this form, it's equivalent to the `subscribe` method, but it better conveys intent, and enables
     writing more consistent binding code.
     - parameter to: Observers to receives events.
     - returns: Disposable object that can be used to unsubscribe the observers.
     */
    func bind<Observer: ObserverType>(to observers: Observer...) -> Disposable where Observer.Element == Element? {
        map { $0 as Element? }
            .subscribe { event in
                observers.forEach { $0.on(event) }
            }
    }

    /**
     Subscribes to observable sequence using custom binder function.

     - parameter to: Function used to bind elements from `self`.
     - returns: Object representing subscription.
     */
    func bind<Result>(to binder: (Self) -> Result) -> Result {
        binder(self)
    }

    /**
     Subscribes to observable sequence using custom binder function and final parameter passed to binder function
     after `self` is passed.

         public func bind<R1, R2>(to binder: Self -> R1 -> R2, curriedArgument: R1) -> R2 {
             return binder(self)(curriedArgument)
         }

     - parameter to: Function used to bind elements from `self`.
     - parameter curriedArgument: Final argument passed to `binder` to finish binding process.
     - returns: Object representing subscription.
     */
    func bind<R1, R2>(to binder: (Self) -> (R1) -> R2, curriedArgument: R1) -> R2 {
        binder(self)(curriedArgument)
    }

    /**
     Subscribes an element handler to an observable sequence.
     In case error occurs in debug mode, `fatalError` will be raised.
     In case error occurs in release mode, `error` will be logged.

     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    func bind(onNext: @escaping (Element) -> Void) -> Disposable {
        subscribe(onNext: onNext)
    }

    /**
     Creates new subscription and sends elements to `BehaviorRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: BehaviorRelay<Element>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }

    /**
     Creates new subscription and sends elements to `BehaviorRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: BehaviorRelay<Element?>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }

    /**
     Creates new subscription and sends elements to `PublishRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: PublishRelay<Element>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }

    /**
     Creates new subscription and sends elements to `PublishRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: PublishRelay<Element?>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }

    /**
     Creates new subscription and sends elements to `ReplayRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: ReplayRelay<Element>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }

    /**
     Creates new subscription and sends elements to `ReplayRelay`.

     - parameter relay: Target relay for sequence elements.
     - returns: Disposable object that can be used to unsubscribe the observer from the relay.
     */
    func bind(to relays: ReplayRelay<Element?>...) -> Disposable {
        return subscribe(onNext: { e in
            relays.forEach { $0.accept(e) }
        })
    }
}
