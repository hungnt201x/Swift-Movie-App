import Foundation
import ObjectMapper

class Movie: Mappable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var posterPath: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        releaseDate <- map["release_date"]
        posterPath <- map["poster_path"]
    }
}
