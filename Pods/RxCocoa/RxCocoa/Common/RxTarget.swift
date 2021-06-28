import Foundation

import RxSwift

class RxTarget: NSObject,
    Disposable
{
    private var retainSelf: RxTarget?

    override init() {
        super.init()
        retainSelf = self

        #if TRACE_RESOURCES
            _ = Resources.incrementTotal()
        #endif

        #if DEBUG
            MainScheduler.ensureRunningOnMainThread()
        #endif
    }

    func dispose() {
        #if DEBUG
            MainScheduler.ensureRunningOnMainThread()
        #endif
        retainSelf = nil
    }

    #if TRACE_RESOURCES
        deinit {
            _ = Resources.decrementTotal()
        }
    #endif
}
