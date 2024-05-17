import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {
    static let manager = NetworkManager()
    
    private func requestData(url: URLConvertible, method: HTTPMethod, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: method, headers: ["Authorization": UrlSession.bearerToken]).responseData { response in
            completion(response.result)
        }
    }
    
    func getMovies(completion: @escaping ([Movie]?) -> Void) {
        requestData(url: UrlSession.trendingUrl, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let results = json["results"] as? [[String: Any]] else {
                        print("Unable to get JSON data.")
                        completion(nil)
                        return
                    }
                    
                    let movies = Mapper<Movie>().mapArray(JSONArray: results)
                    completion(movies)
                } catch {
                    print("Parsing error: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    func getMovieDetail(id: String, completion: @escaping (MovieDetail?) -> Void) {
        requestData(url: UrlSession.detailUrl + id, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Invalid data")
                        completion(nil)
                        return
                    }
                    
                    if let movieDetail = Mapper<MovieDetail>().map(JSON: json) {
                        completion(movieDetail)
                    } else {
                        print("Unable to convert JSON data to MovieDetail object")
                        completion(nil)
                    }
                } catch {
                    print("Parsing error: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
