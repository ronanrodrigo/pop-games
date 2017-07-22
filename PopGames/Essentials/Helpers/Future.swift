class Future<A> {

    private var callbacks: [(Result<A>) -> Void] = []
    private var cached: Result<A>?

    init(compute: (@escaping (Result<A>) -> Void) -> Void) {
        compute(self.then)
    }

    private func then(_ value: Result<A>) {
        assert(cached == nil)
        cached = value
        for callback in callbacks {
            callback(value)
        }
        callbacks = []
    }

    func onResult(_ callback: @escaping (Result<A>) -> Void) {
        if let value = cached {
            callback(value)
        } else {
            callbacks.append(callback)
        }
    }

    func map<B>(_ compute: @escaping (A) -> B) -> Future<B> {
        return Future<B> { completion in
            self.onResult { result in
                switch result {
                case .success(let resultValue):
                    let transformedValue = compute(resultValue)
                    completion(Result.success(transformedValue))
                case .fail(let error):
                    completion(Result.fail(error))

                }
            }
        }
    }

    func flatMap<B>(_ transform: @escaping (A) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            self.onResult { result in
                switch result {
                case .success(let value):
                    transform(value).onResult(completion)
                case .fail(let error):
                    completion(Result.fail(error))
                }
            }
        }
    }

}
