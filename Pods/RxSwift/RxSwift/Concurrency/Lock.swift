protocol Lock {
    func lock()
    func unlock()
}

// https://lists.swift.org/pipermail/swift-dev/Week-of-Mon-20151214/000321.html
typealias SpinLock = RecursiveLock

extension RecursiveLock: Lock {
    @inline(__always)
    final func performLocked<T>(_ action: () -> T) -> T {
        lock(); defer { self.unlock() }
        return action()
    }
}
