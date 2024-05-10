import Foundation
import ObjectMapper

class MovieDetail: Mappable {
    var imageUrl: String?
    var title: String?
    var genres: [Genre]?
    var voteAverage: Double?
    var runtime: Double?
    var overview: String?

    required init?(map: Map){

    }

    func mapping(map: Map) {
        imageUrl <- map["backdrop_path"]
        title <- map["original_title"]
        genres <- map["genres"]
        voteAverage <- map["vote_average"]
        runtime <- map["runtime"]
        overview <- map["overview"]
    }
}
