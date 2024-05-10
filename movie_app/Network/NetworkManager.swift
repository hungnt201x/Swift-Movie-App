import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {
    static let manager = NetworkManager()
    
    private func requestData(url: URLConvertible, method: HTTPMethod, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: method, headers: ["Authorization": UrlConfig.bearerToken]).responseData { response in
            completion(response.result)
        }
    }
    
    func getMovies(completion: @escaping ([Movie]?) -> Void) {
        requestData(url: UrlConfig.trendingUrl, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let results = json["results"] as? [[String: Any]] else {
                        print("Không thể get data JSON.")
                        completion(nil)
                        return
                    }
                    
                    let movies = Mapper<Movie>().mapArray(JSONArray: results)
                    completion(movies)
                } catch {
                    print("Lỗi parse: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Lỗi: \(error)")
                completion(nil)
            }
        }
    }
    
    func getMovieDetail(id: String,completion: @escaping (MovieDetail?) -> Void) {
        requestData(url: UrlConfig.detailUrl+id, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        debugPrint("Dữ liệu không hợp lệ")
                        completion(nil)
                        return
                    }
                    
                    if let movieDetail = Mapper<MovieDetail>().map(JSON: json) {
                        completion(movieDetail)
                    } else {
                        debugPrint("Không thể chuyển đổi dữ liệu JSON thành đối tượng MovieDetail")
                        completion(nil)
                    }
                } catch {
                    debugPrint("Lỗi khi parse: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                debugPrint("Lỗi: \(error)")
                completion(nil)
            }
        }
    }
}

