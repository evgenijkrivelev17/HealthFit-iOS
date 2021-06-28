#if os(iOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UISlider {
        /// Reactive wrapper for `value` property.
        var value: ControlProperty<Float> {
            return base.rx.controlPropertyWithDefaultEvents(getter: { slider in
                slider.value
            }, setter: { slider, value in
                slider.value = value
            })
        }
    }

#endif
