import UIKit

public class BaseViewController: UIViewController, BaseViewControllerProtocol {
    public func configure(_: [String: AnyObject]) {}

    public func back() {}

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
