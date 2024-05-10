<<<<<<< HEAD
import Foundation
import ObjectMapper

class Movie: Mappable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        releaseDate <- map["release_date"]
    }
}

=======
//
//  Movie.swift
//  movie_app
//
//  Created by hungnt1 on 07/05/2024.
//

import Foundation
>>>>>>> main
