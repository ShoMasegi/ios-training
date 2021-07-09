import Foundation

extension Int {
    var withComma: String? {
        let num = NSNumber(integerLiteral: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter.string(from: num)
    }
}