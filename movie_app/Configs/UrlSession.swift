import Foundation

struct UrlSession {
    //Bearer Token
    static let bearerToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMGI2N2MzOTU3NjdkN2EzYTYxMGJiODBlMTk2MjE0ZCIsInN1YiI6IjY2M2Q4OTA4MGYyYzdjMTlhNmM3NTYxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aGC2brcF1iy49bMA4QFGS-SX5HJEofbGoJJLRArVk6M"
    
    //URL
    static let baseUrl = "https://api.themoviedb.org/3"
    static let trendingUrl = baseUrl + "/trending/all/week"
    static let detailUrl = baseUrl + "/movie/"
    
    //Load Image
    static let loadImageUrl =  "https://image.tmdb.org/t/p/w500"
}

