#if os(macOS)

    import Cocoa
    import RxSwift

    public extension Reactive where Base: NSButton {
        /// Reactive wrapper for control event.
        var tap: ControlEvent<Void> {
            controlEvent
        }

        /// Reactive wrapper for `state` property`.
        var state: ControlProperty<NSControl.StateValue> {
            return base.rx.controlProperty(getter: { control in
                control.state
            }, setter: { (control: NSButton, state: NSControl.StateValue) in
                control.state = state
            })
        }
    }

#endif
