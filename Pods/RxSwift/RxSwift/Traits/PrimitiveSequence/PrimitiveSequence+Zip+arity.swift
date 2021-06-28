public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, resultSelector: @escaping (E1, E2) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>)
        -> PrimitiveSequence<Trait, (E1, E2)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, resultSelector: @escaping (E1, E2) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>)
        -> PrimitiveSequence<Trait, (E1, E2)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable())
        )
    }
}

// 3

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, resultSelector: @escaping (E1, E2, E3) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>)
        -> PrimitiveSequence<Trait, (E1, E2, E3)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, resultSelector: @escaping (E1, E2, E3) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>)
        -> PrimitiveSequence<Trait, (E1, E2, E3)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable())
        )
    }
}

// 4

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, resultSelector: @escaping (E1, E2, E3, E4) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, resultSelector: @escaping (E1, E2, E3, E4) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable())
        )
    }
}

// 5

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, resultSelector: @escaping (E1, E2, E3, E4, E5) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, resultSelector: @escaping (E1, E2, E3, E4, E5) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable())
        )
    }
}

// 6

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable())
        )
    }
}

// 7

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6, E7)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6, E7)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable())
        )
    }
}

// 8

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, _ source8: PrimitiveSequence<Trait, E8>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7, E8) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, _ source8: PrimitiveSequence<Trait, E8>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6, E7, E8)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable())
        )
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, _ source8: PrimitiveSequence<Trait, E8>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7, E8) throws -> Element)
        -> PrimitiveSequence<Trait, Element>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable(),
                                                     resultSelector: resultSelector)
        )
    }
}

public extension PrimitiveSequenceType where Element == Any, Trait == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<Trait, E1>, _ source2: PrimitiveSequence<Trait, E2>, _ source3: PrimitiveSequence<Trait, E3>, _ source4: PrimitiveSequence<Trait, E4>, _ source5: PrimitiveSequence<Trait, E5>, _ source6: PrimitiveSequence<Trait, E6>, _ source7: PrimitiveSequence<Trait, E7>, _ source8: PrimitiveSequence<Trait, E8>)
        -> PrimitiveSequence<Trait, (E1, E2, E3, E4, E5, E6, E7, E8)>
    {
        return PrimitiveSequence(raw: Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable())
        )
    }
}
