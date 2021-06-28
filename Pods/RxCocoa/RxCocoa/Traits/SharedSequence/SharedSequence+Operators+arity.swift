import RxSwift

// 2

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, resultSelector: @escaping (O1.Element, O2.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, resultSelector: @escaping (O1.Element, O2.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element)>(source)
    }
}

// 3

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, resultSelector: @escaping (O1.Element, O2.Element, O3.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, resultSelector: @escaping (O1.Element, O2.Element, O3.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element)>(source)
    }
}

// 4

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element)>(source)
    }
}

// 5

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element)>(source)
    }
}

// 6

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element)>(source)
    }
}

// 7

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element)>(source)
    }
}

// 8

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType, O8: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, _ source8: O8, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element) throws -> Element)
        -> SharedSequence<O1.SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy,
        SharingStrategy == O8.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(), source8.asSharedSequence().asObservable(),
                                    resultSelector: resultSelector)

        return SharedSequence<SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func zip<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType, O8: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, _ source8: O8)
        -> SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy,
        SharingStrategy == O8.SharingStrategy
    {
        let source = Observable.zip(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(), source8.asSharedSequence().asObservable())

        return SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element)>(source)
    }
}

public extension SharedSequence {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType, O8: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, _ source8: O8, resultSelector: @escaping (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element) throws -> Element)
        -> SharedSequence<SharingStrategy, Element> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy,
        SharingStrategy == O8.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(), source8.asSharedSequence().asObservable(),
                                              resultSelector: resultSelector)

        return SharedSequence<O1.SharingStrategy, Element>(source)
    }
}

public extension SharedSequenceConvertibleType where Element == Any {
    /**
     Merges the specified observable sequences into one observable sequence of element tuples whenever any of the observable sequences produces an element.

     - returns: An observable sequence containing the result of combining elements of the sources.
     */
    static func combineLatest<O1: SharedSequenceConvertibleType, O2: SharedSequenceConvertibleType, O3: SharedSequenceConvertibleType, O4: SharedSequenceConvertibleType, O5: SharedSequenceConvertibleType, O6: SharedSequenceConvertibleType, O7: SharedSequenceConvertibleType, O8: SharedSequenceConvertibleType>
    (_ source1: O1, _ source2: O2, _ source3: O3, _ source4: O4, _ source5: O5, _ source6: O6, _ source7: O7, _ source8: O8)
        -> SharedSequence<SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element)> where SharingStrategy == O1.SharingStrategy,
        SharingStrategy == O2.SharingStrategy,
        SharingStrategy == O3.SharingStrategy,
        SharingStrategy == O4.SharingStrategy,
        SharingStrategy == O5.SharingStrategy,
        SharingStrategy == O6.SharingStrategy,
        SharingStrategy == O7.SharingStrategy,
        SharingStrategy == O8.SharingStrategy
    {
        let source = Observable.combineLatest(source1.asSharedSequence().asObservable(), source2.asSharedSequence().asObservable(), source3.asSharedSequence().asObservable(), source4.asSharedSequence().asObservable(), source5.asSharedSequence().asObservable(), source6.asSharedSequence().asObservable(), source7.asSharedSequence().asObservable(), source8.asSharedSequence().asObservable())

        return SharedSequence<O1.SharingStrategy, (O1.Element, O2.Element, O3.Element, O4.Element, O5.Element, O6.Element, O7.Element, O8.Element)>(source)
    }
}
