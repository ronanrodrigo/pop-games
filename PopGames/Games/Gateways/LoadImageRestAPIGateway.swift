import Foundation

class LoadImageRestAPIGateway: LoadImageGateway {

    func load(url: String) -> Future<Data> {
        return Future { completion in
            guard let url = URL(string: url) else {
                completion(Result.fail(LoadImageRestAPIGatewayError.invalidURLFormat))
                return
            }

            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                if error == nil, let data = data {
                    completion(Result.success(data))
                } else {
                    completion(Result.fail(error))
                }
            }).resume()
            URLSession.shared.finishTasksAndInvalidate()
        }
    }

}
