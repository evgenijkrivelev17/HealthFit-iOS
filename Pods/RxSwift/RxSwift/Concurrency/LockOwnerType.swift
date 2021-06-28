protocol LockOwnerType: class, Lock {
    var lock: RecursiveLock { get }
}

extension LockOwnerType {
    func lock() { lock.lock() }
    func unlock() { lock.unlock() }
}
