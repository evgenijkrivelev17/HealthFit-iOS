#if os(iOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UIStepper {
        /// Reactive wrapper for `value` property.
        var value: ControlProperty<Double> {
            return base.rx.controlPropertyWithDefaultEvents(getter: { stepper in
                stepper.value
            }, setter: { stepper, value in
                stepper.value = value
            })
        }
    }

#endif
