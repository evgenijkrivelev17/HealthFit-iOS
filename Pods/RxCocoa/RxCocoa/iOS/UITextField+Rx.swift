#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UITextField {
        /// Reactive wrapper for `text` property.
        var text: ControlProperty<String?> {
            value
        }

        /// Reactive wrapper for `text` property.
        var value: ControlProperty<String?> {
            return base.rx.controlPropertyWithDefaultEvents(getter: { textField in
                                                                textField.text
                                                            },
                                                            setter: { textField, value in
                                                                // This check is important because setting text value always clears control state
                                                                // including marked text selection which is imporant for proper input
                                                                // when IME input method is used.
                                                                if textField.text != value {
                                                                    textField.text = value
                                                                }
                                                            })
        }

        /// Bindable sink for `attributedText` property.
        var attributedText: ControlProperty<NSAttributedString?> {
            return base.rx.controlPropertyWithDefaultEvents(getter: { textField in
                                                                textField.attributedText
                                                            },
                                                            setter: { textField, value in
                                                                // This check is important because setting text value always clears control state
                                                                // including marked text selection which is imporant for proper input
                                                                // when IME input method is used.
                                                                if textField.attributedText != value {
                                                                    textField.attributedText = value
                                                                }
                                                            })
        }
    }

#endif
