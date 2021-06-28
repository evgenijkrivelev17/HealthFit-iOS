#if os(iOS)

    import RxSwift
    import UIKit

    /// Marks data source as `UIPickerView` reactive data source enabling it to be used with one of the `bindTo` methods.
    public protocol RxPickerViewDataSourceType {
        /// Type of elements that can be bound to picker view.
        associatedtype Element

        /// New observable sequence event observed.
        ///
        /// - parameter pickerView: Bound picker view.
        /// - parameter observedEvent: Event
        func pickerView(_ pickerView: UIPickerView, observedEvent: Event<Element>)
    }

#endif
