<<<<<<< HEAD
import Foundation
import ObjectMapper

class Genre: Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
=======
//
//  Genre.swift
//  movie_app
//
//  Created by hungnt1 on 10/05/2024.
//

import Foundation
>>>>>>> main
