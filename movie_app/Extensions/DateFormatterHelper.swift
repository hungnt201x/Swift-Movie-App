import Foundation

class DateFormatterHelper {
    
    static func formatDate(from inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: inputDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
}
