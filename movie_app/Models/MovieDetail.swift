import Foundation
import ObjectMapper

class MovieDetail: Mappable {
    var imageUrl: String?
    var title: String?
    var genres: [Genre]?
    var voteAverage: Double?
    var releasedDate: String?
    var runtime: Double?
    var overview: String?

    required init?(map: Map){

    }

    func mapping(map: Map) {
        imageUrl <- map["poster_path"]
        title <- map["original_title"]
        genres <- map["genres"]
        voteAverage <- map["vote_average"]
        releasedDate <- map["release_date"]
        runtime <- map["runtime"]
        overview <- map["overview"]
    }
}
