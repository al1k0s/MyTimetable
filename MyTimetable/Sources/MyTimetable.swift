import Foundation.NSURLSession

public class MyTimetable {

    let rootURL: String
    let urlSession: URLSession

    public init(rootURL: String = "https://mytt.pp.ua/rest/timetable/",
         urlSession: URLSession = .shared) {
        self.rootURL = rootURL
        self.urlSession = urlSession
    }

    public func downloadSchedule(groupName: String,
                          completion: ((Schedule) -> Void)?) {

        let url = urlFrom(groupName: groupName)

        urlSession.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                fatalError(error!.localizedDescription)
            }

            do {
                let schedule = try self.decoder.decode(Schedule.self, from: data)
                completion?(schedule)
            } catch {
                fatalError(error.localizedDescription)
            }

        }.resume()
    }

    func urlFrom(groupName: String) -> URL {
        var urlComponents = URLComponents(string: rootURL)!

        urlComponents.percentEncodedQueryItems =
            [URLQueryItem(name: "group", value: groupName)]
        return urlComponents.url!
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(Schedule.formatter)
        return decoder
    }
}
