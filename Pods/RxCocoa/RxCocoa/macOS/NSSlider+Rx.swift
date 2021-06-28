#if os(macOS)

    import Cocoa
    import RxSwift

    public extension Reactive where Base: NSSlider {
        /// Reactive wrapper for `value` property.
        var value: ControlProperty<Double> {
            return base.rx.controlProperty(getter: { control -> Double in
                                               control.doubleValue
                                           },
                                           setter: { control, value in
                                               control.doubleValue = value
                                           })
        }
    }

#endif
