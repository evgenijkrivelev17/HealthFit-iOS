// 2
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType>
    (_ source1: I1, _ source2: I2, resultSelector: @escaping (I1.Element, I2.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest2(source1: source1.asObservable(), source2: source2.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 3
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, resultSelector: @escaping (I1.Element, I2.Element, I3.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest3(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 4
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType, I4: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, _ source4: I4, resultSelector: @escaping (I1.Element, I2.Element, I3.Element, I4.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest4(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(), source4: source4.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 5
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType, I4: InfallibleType, I5: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, _ source4: I4, _ source5: I5, resultSelector: @escaping (I1.Element, I2.Element, I3.Element, I4.Element, I5.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest5(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(), source4: source4.asObservable(), source5: source5.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 6
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType, I4: InfallibleType, I5: InfallibleType, I6: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, _ source4: I4, _ source5: I5, _ source6: I6, resultSelector: @escaping (I1.Element, I2.Element, I3.Element, I4.Element, I5.Element, I6.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest6(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(), source4: source4.asObservable(), source5: source5.asObservable(), source6: source6.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 7
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType, I4: InfallibleType, I5: InfallibleType, I6: InfallibleType, I7: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, _ source4: I4, _ source5: I5, _ source6: I6, _ source7: I7, resultSelector: @escaping (I1.Element, I2.Element, I3.Element, I4.Element, I5.Element, I6.Element, I7.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest7(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(), source4: source4.asObservable(), source5: source5.asObservable(), source6: source6.asObservable(), source7: source7.asObservable(),
                                  resultSelector: resultSelector))
    }
}

// 8
public extension Infallible {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

     - seealso: [combineLatest operator on reactivex.io](http://reactivex.io/documentation/operators/combinelatest.html)

     - parameter resultSelector: Function to invoke whenever any of the sources produces an element.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func combineLatest<I1: InfallibleType, I2: InfallibleType, I3: InfallibleType, I4: InfallibleType, I5: InfallibleType, I6: InfallibleType, I7: InfallibleType, I8: InfallibleType>
    (_ source1: I1, _ source2: I2, _ source3: I3, _ source4: I4, _ source5: I5, _ source6: I6, _ source7: I7, _ source8: I8, resultSelector: @escaping (I1.Element, I2.Element, I3.Element, I4.Element, I5.Element, I6.Element, I7.Element, I8.Element) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(CombineLatest8(source1: source1.asObservable(), source2: source2.asObservable(), source3: source3.asObservable(), source4: source4.asObservable(), source5: source5.asObservable(), source6: source6.asObservable(), source7: source7.asObservable(), source8: source8.asObservable(),
                                  resultSelector: resultSelector))
    }
}
